import 'package:app/core/data_source/remote_data_source/add_token_interceptor.dart';
import 'package:app/core/shared/imports.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInstance {
  static final DioInstance _singleton = DioInstance._();
  static DioInstance get i => _singleton;
  DioInstance._();

  dio.Dio get instnace {
    final baseUrl = "${appConfig.url}/api/ClientSide";
    logger("=== DIO INSTANCE BASE URL: $baseUrl ===");
    return dio.Dio()
      ..options.baseUrl = baseUrl
      ..options.validateStatus = validateStatus
      ..options.responseType = dio.ResponseType.plain
      ..options.followRedirects = true
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.sendTimeout = const Duration(seconds: 60)
      ..options.receiveDataWhenStatusError = true
      ..options.contentType = "application/json; charset=utf-8"
      ..interceptors.add(AddTokenInterceptor())
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true,
        responseHeader: true,
        error: true,
        logPrint: logger,
        compact: true,
        maxWidth: 150,
      ));
  }

  bool validateStatus(int? v) {
    logger("validateStatus $v");
    return true;
  }
}
