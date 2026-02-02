import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/datasources/customer_double_entrys_remote_data_source.dart';
import 'package:app/feature/customer_double_entrys/data/models/create_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';

class CustomerDoubleEntrysRepositoryImpl
    extends CustomerDoubleEntrysRepositoryAbs {
  final CustomerDoubleEntrysRemoteOperation networkOperation;

  CustomerDoubleEntrysRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, CustomerDoubleEntryDetailsModel?>> getOne(
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
  Future<Either<Failure, ReponseList<CustomerDoubleEntryModel>>> getAll(
      {required CustomerDoubleEntrysFilterModel params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getCustomerDoubleEntrys(
      customerDoubleEntryFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );

    return result;
  }

  @override
  Future<Either<Failure, CustomerDoubleEntryModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreateCustomerDoubleEntryModel model}) async {
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
  Future<Either<Failure, CustomerDoubleEntryModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdateCustomerDoubleEntryModel model,
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
