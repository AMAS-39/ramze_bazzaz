import 'dart:convert';

import 'package:app/core/data_source/remote_data_source/dio_instace.dart';
import 'package:app/core/error/error_checker.dart';
import 'package:app/core/helpers/error_string.dart';
import 'package:app/core/parser/server_error_parser.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';

class StockRemoteOperation {
  Future<Either<Failure, List<StockItemModel>>> getStock({
    required Map<String, dynamic> queryParameters,
    ShowMessage showMessage = ShowMessage.none,
    ShowLoading showLoading = ShowLoading.none,
    String? name,
  }) async {
    try {
      if (showLoading.isShow) showLoadingProgressAlert();
      final response = await DioInstance.i.instnace.get<String>(
        EndPoints.getCustomerStock,
        queryParameters: queryParameters,
      );
      if (showLoading.isShow && Helper.i.context.mounted) Helper.i.context.pop();

      if (isSuccess(response.statusCode)) {
        final body = jsonDecode(response.data ?? "[]");
        final List<dynamic> rawList = body is List
            ? body
            : (body is Map
                ? (body['data'] ?? body['items'] ?? body['Data'] ?? body['Items'] ?? [])
                : []);
        final list = rawList
            .map((e) => StockItemModel.fromMap(Map<String, dynamic>.from(e as Map)))
            .toList();
        return Right(list);
      } else if (response.statusCode == 401) {
        final error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.stock.trans(),
          reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans(),
        );
        await loginStatusAlert(
          title: Trans.failed.trans(),
          desc: error.toString(),
          isAuth: true,
        );
        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404) {
        final error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.stock.trans(),
          reason: parseServerError(
            response.data,
            Trans.notFound.trans(args: [name ?? Trans.stock.trans()]),
            response.statusCode,
          ),
        );
        return Left(EmptyData(error: error));
      } else {
        final error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.stock.trans(),
          reason: parseServerError(
            response.data,
            Trans.unKnownErrorPleaseRetryLater.trans(),
            response.statusCode,
          ),
        );
        return Left(ServerFailure(error: error));
      }
    } catch (e) {
      if (showLoading.isShow && Helper.i.context.mounted) Helper.i.context.pop();
      if (checkIsNetError(e)) {
        final error = getMessage(
          statusCode: 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.stock.trans(),
          reason: Trans.internetConnectionError.trans(),
        );
        return Left(NetworkFailure(error: error));
      }
      final error = getMessage(
        statusCode: 0,
        operationType: OperationType.FailedGetAll,
        name: name ?? Trans.stock.trans(),
        reason: Trans.unKnownErrorPleaseRetryLater.trans(),
      );
      return Left(ErrorFailure(error: error));
    }
  }
}
