import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';

class ContainerExpensesRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  ContainerExpensesRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<ContainerExpenseModel>>>
      getContainerExpenses({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    ShowLoading showLoading = ShowLoading.none,
    required ContainerExpensesFilterModel containerExpenseFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<ContainerExpenseModel>(
      fromJsonModel: ContainerExpenseModel.fromMap,
      endPoint: EndPoints.containerExpenses,
      parseBody: ParseBody.direct,
      showLoading: showLoading,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.containerExpenses.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerExpenseDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required int recordId}) async {
    return await networkOperation.getOne<ContainerExpenseDetailsModel>(
      fromJsonModel: ContainerExpenseDetailsModel.fromMap,
      endPoint: "${EndPoints.containerExpenses}/$recordId",
      queryParameters: params,
      showLoading: showLoading,
      name: Trans.containerExpense.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerExpenseModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreateContainerExpenseModel model}) async {
    return await networkOperation.create<ContainerExpenseModel>(
      fromJsonModel: ContainerExpenseModel.fromMap,
      endPoint: EndPoints.containerExpenses,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.containerExpense.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerExpenseModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdateContainerExpenseModel model}) async {
    return await networkOperation.update<ContainerExpenseModel>(
      fromJsonModel: ContainerExpenseModel.fromMap,
      endPoint: "${EndPoints.containerExpenses}/${model.id}",
      queryParameters: params,
      name: Trans.containerExpense.trans(),
      popupTimes: popupTimes,
      isForm: false,
      showLoading: showLoading,
      body: model.toMap(),
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, UnitModel?>> delete(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required int id}) async {
    return await networkOperation.delete<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: "${EndPoints.containerExpenses}/$id",
      queryParameters: params,
      name: Trans.containerExpense.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
