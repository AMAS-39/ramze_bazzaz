import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/create_attachment_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';
import 'package:app/feature/attachments/domain/usecases/create_attachment_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/delete_attachment_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/get_attachments_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/update_attachment_usecase.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attachments_event.dart';
part 'attachments_state.dart';

class AttachmentsBloc extends Bloc<AttachmentEvent, AttachmentsState> {
  AttachmentsBloc() : super(AttachmentInitialState()) {
    on<AttachmentLoadEvent>(_onLoadAttachmentEvent);
    on<AttachmentEmptyEvent>(_onAttachmentEmptyEvent);
    on<AttachmentDeleteEvent>(_onAttachmentDeleteEvent);
    on<AttachmentCreateEvent>(_onAttachmentCreateEvent);
    on<AttachmentUpdateEvent>(_onAttachmentUpdateEvent);
  }
  Future<void> _onAttachmentEmptyEvent(
      AttachmentEmptyEvent event, Emitter<AttachmentsState> emit) async {
    emit(AttachmentInitialState());
  }

  Future<void> _onAttachmentDeleteEvent(
      AttachmentDeleteEvent event, Emitter<AttachmentsState> emit) async {
    final isDeleted = await sl<DeleteAttachmentUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(AttachmentsLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onAttachmentUpdateEvent(
      AttachmentUpdateEvent event, Emitter<AttachmentsState> emit) async {
    final result = await sl<UpdateAttachmentUsecase>().call(
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
      emit(AttachmentsLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onAttachmentCreateEvent(
      AttachmentCreateEvent event, Emitter<AttachmentsState> emit) async {
    final result = await sl<CreateAttachmentUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(AttachmentsLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadAttachmentEvent(
      AttachmentLoadEvent event, Emitter<AttachmentsState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(AttachmentsLoadingState());
    }
    final result = await sl<GetAttachmentsUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! AttachmentsLoadedState) {
          eimter(AttachmentsErrorState(failure: failure));
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

  AttachmentsState _mapPropsToState(
      ReponseList<AttachmentModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! AttachmentsLoadedState
        ? const AttachmentsEmptyState()
        : AttachmentsLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
