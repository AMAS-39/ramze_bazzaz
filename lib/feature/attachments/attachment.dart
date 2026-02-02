import 'package:app/feature/attachments/data/datasources/attachments_remote_data_source.dart';
import 'package:app/feature/attachments/data/repositories/attachments_repository_impl.dart';
import 'package:app/feature/attachments/domain/repositories/attachments_repository.dart';
import 'package:app/feature/attachments/domain/usecases/create_attachment_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/delete_attachment_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/get_attachment_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/get_attachments_usecase.dart';
import 'package:app/feature/attachments/domain/usecases/update_attachment_usecase.dart';
import 'package:app/feature/attachments/presentation/blocs/all/attachments_bloc.dart';
import 'package:app/injections.dart';

class AttachmentFeature {
  static void init() {
    // //! Attachment Feature
    sl.registerLazySingleton<AttachmentsRemoteOperation>(
        () => AttachmentsRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<AttachmentsRepositoryAbs>(
        () => AttachmentsRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetAttachmentUsecase>(
        () => GetAttachmentUsecase());
    sl.registerLazySingleton<CreateAttachmentUsecase>(
        () => CreateAttachmentUsecase());
    sl.registerLazySingleton<DeleteAttachmentUsecase>(
        () => DeleteAttachmentUsecase());
    sl.registerLazySingleton<UpdateAttachmentUsecase>(
        () => UpdateAttachmentUsecase());
    sl.registerLazySingleton<GetAttachmentsUsecase>(
        () => GetAttachmentsUsecase());
    //!Bloc
    sl.registerLazySingleton<AttachmentsBloc>(() => AttachmentsBloc());
  }

  static void reInitBloc() {
    sl<AttachmentsBloc>().add(const AttachmentEmptyEvent());
  }
}
