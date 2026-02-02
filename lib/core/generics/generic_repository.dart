import 'package:app/core/shared/imports.dart';

/// use for local data that is only viewed not editable
abstract class DeleteGenericRepository<T, S> {
  Future<Either<Failure, T>> delete({
    required S id,
    required Map<String, dynamic> params,
    required ShowMessage showMessage,
    required ShowLoading showLoading,
  });
}

abstract class GetAllGenericRepository<T, S> {
  Future<Either<Failure, ReponseList<T>>> getAll({
    required ShowMessage showMessage,
    required S params,
    ShowLoading showLoading = ShowLoading.none,
    required DataSource dataSource,
    required MetaModel metaModel,
  });
}

abstract class GetOneGenericRepository<T, S> {
  Future<Either<Failure, T>> getOne({
    required S id,
    required ShowMessage showMessage,
    required DataSource dataSource,
    ShowLoading showLoading = ShowLoading.none,
    Map<String, String> params = const {},
  });
}

abstract class UpdateGenericRepository<Input, OutPut> {
  Future<Either<Failure, OutPut?>> update({
    required dynamic id,
    required ShowMessage showMessage,
    required DataSource source,
    required ShowLoading showLoading,
    required Input model,
    Map<String, String> params = const {},
  });
}

abstract class CreateGenericRepository<Input, OutPut> {
  Future<Either<Failure, OutPut?>> create({
    required Map<String, dynamic> params,
    required ShowMessage showMessage,
    required DataSource dataSource,
    required ShowLoading showLoading,
    required Input model,
  });
}
