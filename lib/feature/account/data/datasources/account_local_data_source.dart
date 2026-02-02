// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:app/core/error/failure_message_model.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/model/account_model.dart';
import 'package:app/feature/account/data/model/customer_info_model.dart';
import 'package:app/feature/account/data/model/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountLocalSrc {
  final storage = const FlutterSecureStorage();

  Future<Either<Failure, AccountModel?>> getAccountModel() async {
    var data = await storage.read(key: _USER_DETALIS);
    logger("account data $data");
    if (checkIsNull(data)) {
      return Left(ErrorFailure(
          error: FailureMessage(
        reason: "",
        statusCode: 0,
        message: Trans.unKnownErrorPleaseRetryLater.trans(),
      )));
    }
    final model = AccountModel.fromJson(data!);
    return Right(model);
  }

  Future<Either<Failure, CustomerInfoModel?>> getCustomerInfo() async {
    var data = await storage.read(key: _CUSTOMER_INFO);
    if (checkIsNull(data)) {
      return Left(ErrorFailure(
          error: FailureMessage(
        reason: "",
        statusCode: 0,
        message: Trans.unKnownErrorPleaseRetryLater.trans(),
      )));
    }
    final model = CustomerInfoModel.fromJson(data!);
    return Right(model);
  }

  Future saveAccountModel(AccountModel model) async {
    logger("saveAccountModel 1");
    await storage.write(key: _USER_DETALIS, value: model.toJson());
    logger("saveAccountModel 2");
  }

  Future saveCustomerInfo(CustomerInfoModel model) async {
    await storage.write(key: _CUSTOMER_INFO, value: model.toJson());
  }

  LoginRequestModel? loginRequestModel;
  Future saveAccountListModel(LoginRequestModel model) async {
    logger(model);
    loginRequestModel = (model);
    await storage.write(
        key: _LOCAL_SAVED_ACCOUNT, value: loginRequestModel!.toJson());
  }

  Future init() async {
    try {
      final res = await storage.read(key: _LOCAL_SAVED_ACCOUNT);
      if (res != null) {
        loginRequestModel = LoginRequestModel.fromJson(res);
      }
    } catch (e) {
      logger(e);
    }
  }

  final _USER_DETALIS = "USER_DETALIS";
  final _CUSTOMER_INFO = "CUSTOMER_INFO";
  final _LOCAL_SAVED_ACCOUNT = "LOCAL_SAVED_ACCOUNT";
  Future<void> clearAll() async {
    await storage.delete(key: _USER_DETALIS);
  }
}
