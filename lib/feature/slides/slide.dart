import 'package:app/feature/slides/data/datasources/slides_remote_data_source.dart';
import 'package:app/feature/slides/data/repositories/slides_repository_impl.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';
import 'package:app/feature/slides/domain/usecases/create_slide_usecase.dart';
import 'package:app/feature/slides/domain/usecases/delete_slide_usecase.dart';
import 'package:app/feature/slides/domain/usecases/get_slide_usecase.dart';
import 'package:app/feature/slides/domain/usecases/get_slides_usecase.dart';
import 'package:app/feature/slides/domain/usecases/update_slide_usecase.dart';
import 'package:app/feature/slides/presentation/blocs/all/slides_bloc.dart';
import 'package:app/injections.dart';

class SlideFeature {
  static void init() {
    // //! Slide Feature
    sl.registerLazySingleton<SlidesRemoteOperation>(
        () => SlidesRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<SlidesRepositoryAbs>(
        () => SlidesRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetSlideUsecase>(() => GetSlideUsecase());
    sl.registerLazySingleton<CreateSlideUsecase>(() => CreateSlideUsecase());
    sl.registerLazySingleton<DeleteSlideUsecase>(() => DeleteSlideUsecase());
    sl.registerLazySingleton<UpdateSlideUsecase>(() => UpdateSlideUsecase());
    sl.registerLazySingleton<GetSlidesUsecase>(() => GetSlidesUsecase());
    //!Bloc
    sl.registerLazySingleton<SlidesBloc>(() => SlidesBloc());
  }

  static void reInitBloc() {
    sl<SlidesBloc>().add(const SlideEmptyEvent());
  }
}
