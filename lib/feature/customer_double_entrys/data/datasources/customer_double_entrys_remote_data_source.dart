import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/create_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';

class CustomerDoubleEntrysRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  CustomerDoubleEntrysRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<CustomerDoubleEntryModel>>>
      getCustomerDoubleEntrys({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    ShowLoading showLoading = ShowLoading.none,
    required CustomerDoubleEntrysFilterModel customerDoubleEntryFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<CustomerDoubleEntryModel>(
      fromJsonModel: CustomerDoubleEntryModel.fromMap,
      endPoint: EndPoints.customerDoubleEntries,
      parseBody: ParseBody.direct,
      showLoading: showLoading,
      queryParameters: {
        ...params,
        ...metaModel.toMap(),
        "end": "10000",
        "sort": "id",
        "order": "asc",
      },
      name: Trans.customerDoubleEntries.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, CustomerDoubleEntryDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required int recordId}) async {
    return await networkOperation.getOne<CustomerDoubleEntryDetailsModel>(
      fromJsonModel: CustomerDoubleEntryDetailsModel.fromMap,
      endPoint: "${EndPoints.customerDoubleEntries}/$recordId",
      queryParameters: params,
      showLoading: showLoading,
      name: Trans.customerDoubleEntry.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, CustomerDoubleEntryModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreateCustomerDoubleEntryModel model}) async {
    return await networkOperation.create<CustomerDoubleEntryModel>(
      fromJsonModel: CustomerDoubleEntryModel.fromMap,
      endPoint: EndPoints.customerDoubleEntries,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.customerDoubleEntry.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, CustomerDoubleEntryModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdateCustomerDoubleEntryModel model}) async {
    return await networkOperation.update<CustomerDoubleEntryModel>(
      fromJsonModel: CustomerDoubleEntryModel.fromMap,
      endPoint: "${EndPoints.customerDoubleEntries}/${model.id}",
      queryParameters: params,
      name: Trans.customerDoubleEntry.trans(),
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
      endPoint: "${EndPoints.customerDoubleEntries}/$id",
      queryParameters: params,
      name: Trans.customerDoubleEntry.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
