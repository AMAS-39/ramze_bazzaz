import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';
import 'package:app/feature/attachments/domain/usecases/get_attachment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attachment_event.dart';
part 'attachment_state.dart';

class OneAttachmentBloc extends Bloc<OneAttachmentEvent, OneAttachmentState> {
  OneAttachmentBloc() : super(OneAttachmentInitialState()) {
    on<OneAttachmentGetEvent>(oneAttachmentGetEvent);
  }
  Future<Either<Failure, AttachmentDetailsModel?>> oneAttachmentGetEvent(
      OneAttachmentGetEvent event, Emitter<OneAttachmentState> emiter) async {
    emiter(OneAttachmentLoadingState());

    final result = await sl<GetAttachmentUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneAttachmentLoadedState) {
        emiter(OneAttachmentErrorState(failure: failure));
      } else if (state is OneAttachmentLoadedState) {
        emiter(OneAttachmentLoadedState(
            data: (state as OneAttachmentLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneAttachmentState _mapPropsToState(AttachmentDetailsModel? attachment) {
    return attachment == null
        ? const OneAttachmentEmptyState()
        : OneAttachmentLoadedState(failure: null, data: attachment);
  }
}
