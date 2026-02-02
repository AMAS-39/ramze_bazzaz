import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/datasources/container_expenses_remote_data_source.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class ContainerExpensesRepositoryImpl extends ContainerExpensesRepositoryAbs {
  final ContainerExpensesRemoteOperation networkOperation;

  ContainerExpensesRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, ContainerExpenseDetailsModel?>> getOne(
      {required int id,
      required ShowMessage showMessage,
      ShowLoading showLoading = ShowLoading.none,
      int popupTimes = 0,
      required DataSource dataSource,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.getOne(
        popupTimes: popupTimes,
        recordId: id,
        params: params,
        showMessage: showMessage);

    return res;
  }

  @override
  Future<Either<Failure, ReponseList<ContainerExpenseModel>>> getAll(
      {required ContainerExpensesFilterModel params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getContainerExpenses(
      containerExpenseFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );
    return result;
  }

  @override
  Future<Either<Failure, ContainerExpenseModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreateContainerExpenseModel model}) async {
    final res = await networkOperation.create(
        showLoading: showLoading,
        params: params,
        popupTimes: popupTimes,
        showMessage: showMessage,
        model: model);

    return res;
  }

  @override
  Future<Either<Failure, UnitModel?>> delete(
      {required int id,
      required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading}) async {
    final res = await networkOperation.delete(
        params: params,
        showMessage: showMessage,
        showLoading: showLoading,
        popupTimes: popupTimes,
        id: id);

    return res;
  }

  @override
  Future<Either<Failure, ContainerExpenseModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdateContainerExpenseModel model,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.update(
        params: params,
        showMessage: showMessage,
        popupTimes: popupTimes,
        showLoading: showLoading,
        model: model);

    return res;
  }
}
