// ignore_for_file: use_build_context_synchronously

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/model/customer_info_model.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_info_event.dart';
part 'customer_info_status.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  final AccountRepo repository;
  CustomerInfoBloc({required this.repository}) : super(CustomerInfoInitial()) {
    on<CustomerInfoFromLocalEvent>(_onLocal);
    on<CustomerInfoFromRemoteEvent>(_onRemote);
    on<CustomerInfoSetEvent>(_onLoginSetEvent);
  }

  Future<void> _onLoginSetEvent(
      CustomerInfoSetEvent event, Emitter<CustomerInfoState> emit) async {
    logger("event.data ${event.data}");
    repository.saveCustomerInfoModel(event.data);
    emit(CustomerInfoLoadedState(data: event.data));
  }

  Future<Either<Failure, CustomerInfoModel?>> _onLocal(
      CustomerInfoFromLocalEvent event, Emitter<CustomerInfoState> emit) async {
    final result = await repository.getCustomerInfoFromLocal();

    result.fold(
      (failure) => emit(CustomerInfoErrorState(failure: failure)),
      (data) {
        emit(_mapPropsToState(data));
      },
    );
    logger(state);
    return result;
  }

  Future<Either<Failure, CustomerInfoModel?>> _onRemote(CustomerInfoFromRemoteEvent event,
      Emitter<CustomerInfoState> emit) async {
    final result = await repository.getInfo();
    result.fold(
      (failure) => emit(CustomerInfoErrorState(failure: failure)),
      (data) {
        emit(_mapPropsToState(data));
      },
    );
    logger(state);
    return result;
  }

  CustomerInfoModel? get info {
    if (state is CustomerInfoLoadedState) {
      return (state as CustomerInfoLoadedState).data;
    }
    return null;
  }

  CustomerInfoState _mapPropsToState(CustomerInfoModel? entities) {
    return entities == null
        ? const CustomerInfoEmptyState()
        : CustomerInfoLoadedState(data: entities);
  }
}
