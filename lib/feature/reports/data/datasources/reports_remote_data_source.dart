import 'dart:convert';

import 'package:app/core/data_source/remote_data_source/dio_instace.dart';
import 'package:app/core/error/error_checker.dart';
import 'package:app/core/helpers/error_string.dart';
import 'package:app/core/parser/server_error_parser.dart';
import 'package:app/core/shared/imports.dart';

class ReportsRemoteDataSource {
  /// GET statement endpoint; returns decoded body (List or Map) or Failure.
  Future<Either<Failure, dynamic>> fetchStatement({
    required String endpoint,
    required Map<String, dynamic> queryParameters,
    String? name,
  }) async {
    try {
      logger("STATEMENTS: ReportsRemoteDataSource.fetchStatement GET $endpoint, query=$queryParameters");
      final response = await DioInstance.i.instnace.get<String>(
        endpoint,
        queryParameters: queryParameters,
      );
      logger("STATEMENTS: fetchStatement statusCode=${response.statusCode}");
      if (isSuccess(response.statusCode)) {
        final body = jsonDecode(response.data ?? '[]');
        logger("STATEMENTS: fetchStatement success, body type=${body.runtimeType}");
        return Right(body);
      }
      if (response.statusCode == 401) {
        final error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.statements.trans(),
          reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans(),
        );
        await loginStatusAlert(
          title: Trans.failed.trans(),
          desc: error.toString(),
          isAuth: true,
        );
        return Left(UnAuthFailure(error: error));
      }
      if (response.statusCode == 404) {
        final error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.statements.trans(),
          reason: parseServerError(
            response.data,
            Trans.notFound.trans(args: [name ?? Trans.statements.trans()]),
            response.statusCode,
          ),
        );
        return Left(EmptyData(error: error));
      }
      final error = getMessage(
        statusCode: response.statusCode ?? 0,
        operationType: OperationType.FailedGetAll,
        name: name ?? Trans.statements.trans(),
        reason: parseServerError(
          response.data,
          Trans.unKnownErrorPleaseRetryLater.trans(),
          response.statusCode,
        ),
      );
      return Left(ServerFailure(error: error));
    } catch (e) {
      if (checkIsNetError(e)) {
        final error = getMessage(
          statusCode: 0,
          operationType: OperationType.FailedGetAll,
          name: name ?? Trans.statements.trans(),
          reason: Trans.internetConnectionError.trans(),
        );
        return Left(NetworkFailure(error: error));
      }
      final error = getMessage(
        statusCode: 0,
        operationType: OperationType.FailedGetAll,
        name: name ?? Trans.statements.trans(),
        reason: Trans.unKnownErrorPleaseRetryLater.trans(),
      );
      return Left(ErrorFailure(error: error));
    }
  }
}
