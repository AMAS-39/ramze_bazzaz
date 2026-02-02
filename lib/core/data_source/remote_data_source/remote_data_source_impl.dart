import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/core/data_source/remote_data_source/dio_instace.dart';
import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/error/error_checker.dart';
import 'package:app/core/error/failure_message_model.dart';
import 'package:app/core/helpers/error_string.dart';
import 'package:app/core/model/files.dart';
import 'package:app/core/parser/remote_object_parser.dart';
import 'package:app/core/parser/server_error_parser.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class RemoveDataSourceImp implements RemoteDataSourceAbs {
  bool showLogs = true;
  @override
  Future<Either<Failure, T?>> create<T>({
    required String endPoint,
    String? name,
    int popupTimes = 0,
    bool logout = true,
    ParseBody parseBody = ParseBody.none,
    ShowLoading showLoading = ShowLoading.none,
    Map<String, dynamic> queryParameters = const {},
    required Map<String, dynamic> body,
    String? errorMsg,
    dio.CancelToken? cancelToken,
    bool isForm = false,
    List<FileForm> files = const [],
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessage showMessage = ShowMessage.none,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await DioInstance.i.instnace.post<String>(
        endPoint,
        cancelToken: cancelToken,
        data: isForm ? await _formData(files, body) : jsonEncode(body),
        queryParameters: queryParameters,
      );
      _closeLoading(showLoading);

      if (isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);
        await _showSuccessMessage(
            showMessage,
            getMessage(
                statusCode: response.statusCode ?? 0,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessAddOne));
        return Right(parseBodyOne(ResRemote<T>(
            parseBody: parseBody,
            params: queryParameters,
            header: response.headers.map,
            body: response.data!,
            fromJsonModel: fromJsonModel)));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: parseServerError(
                response.data,
                sl<AccountBloc>().info == null
                    ? (errorMsg ??
                        Trans.youAreNotAuthorizedReloginAndRetryAgain.trans())
                    : Trans.youAreNotAuthorizedReloginAndRetryAgain.trans(),
                response.statusCode));

        await loginStatusAlert(
            title: Trans.failed.trans(),
            desc: error.toString(),
            isAuth: logout);

        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: parseServerError(response.data,
                Trans.notFound.trans(args: [name]), response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(EmptyData(error: error));
      } else {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedAddOne,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } on Exception catch (e) {
      _closeLoading(showLoading);
      return Left(await handleExceptions(
          e: e,
          errorMsg: errorMsg,
          showMessage: showMessage,
          name: name,
          operationType: OperationType.FailedAddOne));
    }
  }

  @override
  Future<Either<Failure, T?>> delete<T>(
      {required String endPoint,
      String? errorMsg,
      required T Function(Map<String, dynamic>) fromJsonModel,
      int popupTimes = 0,
      dio.CancelToken? cancelToken,
      ShowLoading showLoading = ShowLoading.none,
      String? name,
      Map<String, dynamic> queryParameters = const {},
      ShowMessage showMessage = ShowMessage.none,
      String? successMsg}) async {
    try {
      _showLoading(showLoading);
      final response = await DioInstance.i.instnace.delete<String>(
        endPoint,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      _closeLoading(showLoading);
      if (isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);
        await _showSuccessMessage(
            showMessage,
            getMessage(
                statusCode: response.statusCode ?? 0,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessDelete));
        return Right(parseBodyOne(ResRemote<T>(
            parseBody: ParseBody.direct,
            header: response.headers.map,
            body: response.data!,
            params: queryParameters,
            fromJsonModel: fromJsonModel)));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: parseServerError(response.data,
                Trans.notFound.trans(args: [name]), response.statusCode));

        await _showErrorMessage(showMessage, error);
        return Left(EmptyData(error: error));
      } else {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedDelete,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e) {
      _closeLoading(showLoading);
      return Left(await handleExceptions(
          e: e,
          errorMsg: errorMsg,
          showMessage: showMessage,
          name: name,
          operationType: OperationType.FailedDelete));
    }
  }

  @override
  Future<Either<Failure, ReponseList<T>>> getData<T>({
    required String endPoint,
    ShowLoading showLoading = ShowLoading.none,
    String? name,
    int popupTimes = 0,
    ParseBody parseBody = ParseBody.direct,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    Map<String, dynamic> queryParameters = const {},
    ShowMessage showMessage = ShowMessage.none,
    String? errorMsg,
    dio.CancelToken? cancelToken,
    String? successMsg,
  }) async {
    // try {
    _showLoading(showLoading);
    final response = await DioInstance.i.instnace.get<String>(
      endPoint,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    _closeLoading(showLoading);
    if (isSuccess(response.statusCode)) {
      _popUpTimes(popupTimes);

      final ReponseList<T> res = await compute(
          parseBodyList,
          ResRemote<T>(
              header: response.headers.map,
              parseBody: parseBody,
              params: queryParameters,
              body: response.data ?? "[]",
              fromJsonModel: fromJsonModel));
      await _showSuccessMessage(
          showMessage,
          getMessage(
              statusCode: response.statusCode ?? 0,
              length: res.data.length,
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessGetAll));

      return Right(res);
    } else if (response.statusCode == 401) {
      FailureMessage error = getMessage(
          statusCode: response.statusCode ?? 0,
          message: errorMsg,
          operationType: OperationType.FailedGetAll,
          name: name,
          reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());

      await loginStatusAlert(
          title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

      return Left(UnAuthFailure(error: error));
    } else if (response.statusCode == 404) {
      FailureMessage error = getMessage(
          statusCode: response.statusCode ?? 0,
          message: errorMsg,
          operationType: OperationType.FailedGetAll,
          name: name,
          reason: parseServerError(response.data,
              Trans.notFound.trans(args: [name]), response.statusCode));

      await _showErrorMessage(showMessage, error);
      return Left(EmptyData(error: error));
    } else {
      FailureMessage error = getMessage(
          statusCode: response.statusCode ?? 0,
          operationType: OperationType.FailedGetAll,
          message: errorMsg,
          name: name,
          reason: parseServerError(response.data,
              Trans.unKnownErrorPleaseRetryLater.trans(), response.statusCode));
      await _showErrorMessage(showMessage, error);
      return Left(ServerFailure(error: error));
    }
    // } catch (e) {
    //   _closeLoading(showLoading);
    //   return Left(await handleExceptions(
    //       e: e,
    //       errorMsg: errorMsg,
    //       showMessage: showMessage,
    //       name: name,
    //       operationType: OperationType.FailedGetAll));
    // }
  }

  void _popUpTimes(int popTimes) {
    for (var i = 0; i < popTimes; i++) {
      Helper.i.context.pop();
    }
  }

  @override
  Future<Either<Failure, T?>> getOne<T>({
    required String endPoint,
    String? name,
    dio.CancelToken? cancelToken,
    ShowLoading showLoading = ShowLoading.none,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessage showMessage = ShowMessage.none,
    Map<String, dynamic> queryParameters = const {},
    String? errorMsg,
    int popupTimes = 0,
    bool withIsolate = false,
    ParseBody parseBody = ParseBody.none,
    String? successMsg,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await DioInstance.i.instnace.get<String>(
        endPoint,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      _closeLoading(showLoading);
      if (isSuccess(response.statusCode)) {
        T? rssul;
        if (withIsolate) {
          rssul = await compute(
              parseBodyOne,
              ResRemote<T>(
                  parseBody: parseBody,
                  header: response.headers.map,
                  params: queryParameters,
                  body: response.data!,
                  fromJsonModel: fromJsonModel));
        } else {
          rssul = parseBodyOne(ResRemote<T>(
              parseBody: parseBody,
              header: response.headers.map,
              params: queryParameters,
              body: response.data!,
              fromJsonModel: fromJsonModel));
        }
        _popUpTimes(popupTimes);

        await _showSuccessMessage(
            showMessage,
            getMessage(
                statusCode: response.statusCode ?? 0,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetOne));
        return Right(rssul);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404 || response.statusCode == 204) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: parseServerError(response.data,
                Trans.notFound.trans(args: [name]), response.statusCode));

        await _showErrorMessage(showMessage, error);
        return Left(EmptyData(error: error));
      } else {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedGetOne,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e) {
      _closeLoading(showLoading);
      return Left(await handleExceptions(
          e: e,
          errorMsg: errorMsg,
          showMessage: showMessage,
          name: name,
          operationType: OperationType.FailedGetOne));
    }
  }

  @override
  Future<Either<Failure, T?>> update<T>({
    required String endPoint,
    String? name,
    bool isForm = false,
    int popupTimes = 0,
    dio.CancelToken? cancelToken,
    ParseBody parseBody = ParseBody.none,
    List<FileForm> files = const [],
    ShowLoading showLoading = ShowLoading.none,
    required Map<String, dynamic> body,
    Map<String, dynamic> queryParameters = const {},
    String? errorMsg,
    String? successMsg,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessage showMessage = ShowMessage.none,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await DioInstance.i.instnace.put<String>(
        endPoint,
        cancelToken: cancelToken,
        data: isForm ? await _formData(files, body) : jsonEncode(body),
        queryParameters: queryParameters,
      );

      _closeLoading(showLoading);
      if (isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);

        await _showSuccessMessage(
            showMessage,
            getMessage(
                statusCode: response.statusCode ?? 0,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessUpdate));
        return Right(parseBodyOne(ResRemote<T>(
            parseBody: parseBody,
            params: queryParameters,
            header: response.headers.map,
            body: response.data!,
            fromJsonModel: fromJsonModel)));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);
        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: parseServerError(response.data,
                Trans.notFound.trans(args: [name]), response.statusCode));

        await _showErrorMessage(showMessage, error);
        return Left(EmptyData(error: error));
      } else {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedUpdate,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e) {
      _closeLoading(showLoading);
      return Left(await handleExceptions(
          e: e,
          errorMsg: errorMsg,
          showMessage: showMessage,
          name: name,
          operationType: OperationType.FailedUpdate));
    }
  }

  void _showLoading(ShowLoading showLoading) {
    if (showLoading.isShow) {
      showLoadingProgressAlert();
    }
  }

  void _closeLoading(ShowLoading showLoading) {
    if (showLoading.isShow) {
      Helper.i.context.pop();
    }
  }

  Future<void> _showErrorMessage(
      ShowMessage showMessage, FailureMessage message) async {
    if (showMessage.failedAlert) {
      await failedAlert(body: message.reason, title: message.message);
    } else if (showMessage.failedToast) {
      showFailedFlashBar(message.toString());
    }
  }

  Future<void> _showSuccessMessage(
      ShowMessage showMessage, FailureMessage message) async {
    if (showMessage.successAlert) {
      await successAlert(body: message.toString());
    } else if (showMessage.successToast) {
      showSuccessFlashBar(message.toString());
    }
  }

  Future<dio.FormData> _formData(
      List<FileForm> paths, Map<String, dynamic> maps) async {
    logger("maps $maps ,paths $paths");
    if (paths.isEmpty) {
      return dio.FormData.fromMap({...maps});
    } else {
      Map<String, List<dio.MultipartFile>> files = {};
      for (var e in paths) {
        files[e.key] = await Future.wait(e.files.map((e) async =>
            await dio.MultipartFile.fromFile(e, filename: e.split('/').last)));
      }
      return dio.FormData.fromMap({...maps, ...files});
    }
  }

  @override
  Future<Either<Failure, T?>> sendFile<T>(
      {required String endPoint,
      Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> headers = const {},
      required File data,
      String? errorMsg,
      dio.CancelToken? cancelToken,
      required String fileType,
      bool logout = true,
      int popupTimes = 0,
      ParseBody parseBody = ParseBody.none,
      String? name,
      ShowLoading showLoading = ShowLoading.none,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      String? successMsg,
      ShowMessage showMessage = ShowMessage.none}) async {
    try {
      _showLoading(showLoading);
      final response = await DioInstance.i.instnace.post<String>(
        endPoint,
        cancelToken: cancelToken,
        data: data.openRead(),
        options: dio.Options(
          validateStatus: (status) {
            return true;
          },
          headers: headers,
        ),
        queryParameters: queryParameters,
      );
      _closeLoading(showLoading);

      if (isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);

        await _showSuccessMessage(
            showMessage,
            getMessage(
                statusCode: response.statusCode ?? 0,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessAddOne));
        return Right(parseBodyOne(ResRemote<T>(
            parseBody: parseBody,
            params: queryParameters,
            header: response.headers.map,
            body: response.data!,
            fromJsonModel: fromJsonModel)));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.youAreNotAuthorizedReloginAndRetryAgain.trans(),
                response.statusCode));
        await loginStatusAlert(
            title: Trans.failed.trans(),
            desc: error.toString(),
            isAuth: logout);

        return Left(UnAuthFailure(error: error));
      } else if (response.statusCode == 404) {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: parseServerError(response.data,
                Trans.notFound.trans(args: [name]), response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(EmptyData(error: error));
      } else {
        FailureMessage error = getMessage(
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedAddOne,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } on Exception catch (e) {
      _closeLoading(showLoading);
      return Left(await handleExceptions(
          e: e,
          errorMsg: errorMsg,
          showMessage: showMessage,
          name: name,
          operationType: OperationType.FailedAddOne));
    }
  }

  Future<Failure> handleExceptions({
    required dynamic e,
    required String? errorMsg,
    required ShowMessage showMessage,
    required String? name,
    required OperationType operationType,
  }) async {
    if (checkIsNetError(e)) {
      FailureMessage error = getMessage(
          statusCode: 0,
          message: errorMsg,
          operationType: operationType,
          name: name,
          reason: Trans.internetConnectionError.trans());
      await _showErrorMessage(showMessage, error);
      return (NetworkFailure(error: error));
    } else {
      FailureMessage error = getMessage(
          statusCode: 0,
          message: errorMsg,
          operationType: operationType,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      await _showErrorMessage(showMessage, error);
      return (ErrorFailure(error: error));
    }
  }
}
