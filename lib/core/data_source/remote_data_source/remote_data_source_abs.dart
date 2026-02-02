import 'dart:io';

import 'package:app/core/model/files.dart';
import 'package:app/core/shared/imports.dart';
import 'package:dio/dio.dart';

//abstract class for all Remove Data Source
abstract class RemoteDataSourceAbs {
  Future<Either<Failure, T?>> delete<T>(
      {required String endPoint,
      String? name,
      Map<String, dynamic> queryParameters = const {},
      ShowMessage showMessage,
      ShowLoading showLoading,
      CancelToken? cancelToken,
      String? errorMsg,
      required T Function(Map<String, dynamic>) fromJsonModel,
      int popupTimes,
      String? successMsg});
  Future<Either<Failure, T?>> create<T>({
    required String endPoint,
    Map<String, dynamic> queryParameters = const {},
    required Map<String, dynamic> body,
    String? errorMsg,
    bool logout,
    int popupTimes,
    ParseBody parseBody,
    CancelToken? cancelToken,
    bool isForm = false,
    List<FileForm> files = const [],
    String? name,
    ShowLoading showLoading,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessage showMessage,
  });
  Future<Either<Failure, T?>> sendFile<T>({
    required String endPoint,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
    required File data,
    String? errorMsg,
    required String fileType,
    bool logout,
    int popupTimes,
    CancelToken? cancelToken,
    ParseBody parseBody,
    String? name,
    ShowLoading showLoading,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessage showMessage,
  });
  Future<Either<Failure, ReponseList<T>>> getData<T>({
    required String endPoint,
    required ParseBody parseBody,
    String? name,
    CancelToken? cancelToken,
    ShowMessage showMessage,
    Map<String, dynamic> queryParameters = const {},
    String? errorMsg,
    int popupTimes,
    ShowLoading showLoading,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
  });
  Future<Either<Failure, T?>> getOne<T>({
    required String endPoint,
    ParseBody parseBody,
    ShowMessage showMessage,
    ShowLoading showLoading,
    Map<String, dynamic> queryParameters = const {},
    String? name,
    CancelToken? cancelToken,
    bool withIsolate = false,
    int popupTimes,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? errorMsg,
    String? successMsg,
  });
  Future<Either<Failure, T?>> update<T>({
    required String endPoint,
    ShowLoading showLoading,
    Map<String, dynamic> queryParameters = const {},
    ShowMessage showMessage,
    bool isForm = false,
    int popupTimes,
    ParseBody parseBody,
    List<FileForm> files,
    String? name,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    required Map<String, dynamic> body,
    String? errorMsg,
    CancelToken? cancelToken,
    String? successMsg,
  });
}
