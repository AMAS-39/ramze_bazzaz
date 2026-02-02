import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';
import 'package:app/feature/packages/domain/usecases/create_package_usecase.dart';
import 'package:app/feature/packages/domain/usecases/delete_package_usecase.dart';
import 'package:app/feature/packages/domain/usecases/get_packages_usecase.dart';
import 'package:app/feature/packages/domain/usecases/update_package_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'packages_event.dart';
part 'packages_state.dart';

class PackagesBloc extends Bloc<PackageEvent, PackagesState> {
  PackagesBloc() : super(PackageInitialState()) {
    on<PackageLoadEvent>(_onLoadPackageEvent);
    on<PackageEmptyEvent>(_onPackageEmptyEvent);
    on<PackageDeleteEvent>(_onPackageDeleteEvent);
    on<PackageCreateEvent>(_onPackageCreateEvent);
    on<PackageUpdateEvent>(_onPackageUpdateEvent);
  }
  Future<void> _onPackageEmptyEvent(
      PackageEmptyEvent event, Emitter<PackagesState> emit) async {
    emit(PackageInitialState());
  }

  Future<void> _onPackageDeleteEvent(
      PackageDeleteEvent event, Emitter<PackagesState> emit) async {
    final isDeleted = await sl<DeletePackageUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(PackagesLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onPackageUpdateEvent(
      PackageUpdateEvent event, Emitter<PackagesState> emit) async {
    final result = await sl<UpdatePackageUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      final newData = state.items
          .map((element) => element.id != event.model.id
              ? element
              : result.getRight(() => null) != null
                  ? result.getRight(() => null)!
                  : element)
          .toList();
      emit(PackagesLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onPackageCreateEvent(
      PackageCreateEvent event, Emitter<PackagesState> emit) async {
    final result = await sl<CreatePackageUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(PackagesLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadPackageEvent(
      PackageLoadEvent event, Emitter<PackagesState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(PackagesLoadingState());
    }
    final result = await sl<GetPackagesUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! PackagesLoadedState) {
          eimter(PackagesErrorState(failure: failure));
        }
        event.onDone?.call(LoadingMoreEvent(
            status: LoadingMoreStatus(
                failure: failure, pagination: Pagination.error)));
      },
      (data) {
        event.onDone?.call(const LoadingMoreEvent(
            status: LoadingMoreStatus(pagination: Pagination.notMatch)));
        eimter(_mapPropsToState(
            data, currentPage(event.refresh, state.metaModel)));
      },
    );
    logger(state);
  }

  PackagesState _mapPropsToState(ReponseList<PackageModel>? data, int page) {
    if (data == null) {
      return state;
    }
    final list = [if (page != firstPage) ...state.items, ...data.data];
    if (appConfig.isRbb) {
      list.sort((a, b) {
//esponse.Entries?.OrderByDescending(x=>x.Container?.ArrivalDate.HasValue).ThenBy(x => x.Container?.ArrivalDate).ThenBy(x => x.Container?.ShippingDate).ToList();
        if (a.container.arrivalDate != null &&
            b.container.arrivalDate != null) {
          return (a.container.arrivalDate!).compareTo(b.container.arrivalDate!);
        } else if (a.container.shippingDate == null ||
            b.container.shippingDate == null) {
          return 1;
        }

        return (a.container.shippingDate!).compareTo(b.container.shippingDate!);
      });
    }

    return data.data.isEmpty && state is! PackagesLoadedState
        ? const PackagesEmptyState()
        : PackagesLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta), data: list);
  }
}
