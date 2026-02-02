import 'dart:async';
import 'dart:io';

import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/model/files.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/model/account_model.dart';
import 'package:app/feature/account/data/model/change_account_info_model.dart';
import 'package:app/feature/account/data/model/change_password_model.dart';
import 'package:app/feature/account/data/model/customer_info_model.dart';
import 'package:app/feature/account/data/model/forget_password_model.dart';
import 'package:app/feature/account/data/model/login_model.dart';
import 'package:app/feature/account/data/model/register_model.dart';
import 'package:app/feature/account/data/model/update_account_reposne.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class AccountRemoteSrc {
  late RemoteDataSourceAbs networkOperation;

  AccountRemoteSrc({required this.networkOperation});

  Future<Either<Failure, UpdateAccountRep?>> updateUser({
    required ChangeAccountInfo loginModel,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.create(
        errorMsg: Trans.failedToUpdatePersonalInformation.trans(),
        showLoading: showLoading,
        logout: false,
        popupTimes: 1,
        successMsg: Trans.scuccefullyUpdatePersonalInformation.trans(),
        endPoint: EndPoints.accountsChangeAccountInfo,
        showMessage: ShowMessage.bothToast,
        body: loginModel.toJson(),
        fromJsonModel: UpdateAccountRep.fromMap);

    return res;
  }

  Future<Either<Failure, UnitModel?>> register({
    required RegisterModel loginModel,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.create(
        errorMsg: Trans.failedToRegister.trans(),
        showLoading: showLoading,
        logout: false,
        isForm: false,
        popupTimes: 1,
        successMsg: Trans.youHaveSuccessfullyRegistered.trans(),
        endPoint: EndPoints.register,
        showMessage: ShowMessage.none,
        body: loginModel.toMap(),
        fromJsonModel: UnitModel.fromMap);
    await successAlert(body: Trans.youReceivedYourRequuestWiatApproval.trans());
    Helper.i.context.pop();
    return res;
  }

  Future<Either<Failure, UnitModel?>> forgetPassowrd({
    required ForgetPasswordModel data,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.create(
        errorMsg: Trans.failedToSendForgetPasswordRequest.trans(),
        showLoading: showLoading,
        logout: false,
        isForm: false,
        popupTimes: 1,
        successMsg: Trans.forgetPasswordRequestWasSentSuccessfully.trans(),
        endPoint: EndPoints.resetPassword,
        showMessage: ShowMessage.failedAlert,
        body: data.toMap(),
        fromJsonModel: UnitModel.fromMap);

    return res;
  }

  Future<Either<Failure, UnitModel?>> requestDeleteAccount({
    required Map<String, dynamic> params,
    required ShowMessage showMessage,
    required ShowLoading showLoading,
  }) async {
    final result = await networkOperation.update<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: EndPoints.deleteAccount,
      queryParameters: params,
      errorMsg: Trans.failedToRequestDeleteAccount.trans(),
      parseBody: ParseBody.data,
      successMsg: Trans
          .yourReuestHasBeenSubmittedWeWillDeleteYourAccountInBusinessDays
          .trans(args: ["3-5"]),
      isForm: false,
      showLoading: showLoading,
      body: {"type": "account-delete"},
      showMessage: showMessage,
    );
    await successAlert(
        body: Trans
            .yourReuestHasBeenSubmittedWeWillDeleteYourAccountInBusinessDays
            .trans(args: ["3-5"]));
    return result;
  }

  Future<Either<Failure, UnitModel?>> changePassword({
    required ChangePasswordModel changePassword,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.update(
        errorMsg: Trans.failedToChangePassword.trans(),
        showLoading: showLoading,
        successMsg: Trans.scuccefullyChangePassword.trans(),
        endPoint: EndPoints.changePasswor,
        showMessage: ShowMessage.bothToast,
        body: changePassword.toJson(),
        fromJsonModel: UnitModel.fromMap,
        isForm: false);

    return res;
  }

  Future<Either<Failure, UpdateAccountRep?>> changeAccountImage({
    required String path,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.create(
        errorMsg: Trans.failedToUpdatePersonalInformation.trans(),
        showLoading: showLoading,
        logout: false,
        files: [
          FileForm(files: [path], key: "files")
        ],
        successMsg: Trans.scuccefullyUpdatePersonalInformation.trans(),
        endPoint: EndPoints.accountsChangeAccountInfo,
        showMessage: ShowMessage.bothToast,
        body: {},
        isForm: true,
        fromJsonModel: UpdateAccountRep.fromMap);

    return res;
  }

  Future<Either<Failure, AccountModel?>> getProfile({
    required String path,
    required ShowLoading showLoading,
  }) async {
    final res = await networkOperation.create(
        errorMsg: Trans.failedToUpdatePersonalInformation.trans(),
        showLoading: showLoading,
        logout: true,
        successMsg: Trans.scuccefullyUpdatePersonalInformation.trans(),
        endPoint: EndPoints.accountsChangeAccountInfo,
        showMessage: ShowMessage.bothToast,
        body: {},
        isForm: true,
        fromJsonModel: AccountModel.fromMap);

    return res;
  }

  Future<Either<Failure, CustomerInfoModel?>> getCustomerInfo() async {
    final res = await networkOperation.getOne(
        errorMsg: Trans.success.trans(args: [Trans.accountInformation.trans()]),
        showLoading: ShowLoading.none,
        successMsg: Trans.successToGetOne
            .trans(args: [Trans.accountInformation.trans()]),
        endPoint: EndPoints.customerInfo,
        showMessage: ShowMessage.bothToast,
        fromJsonModel: CustomerInfoModel.fromMap);

    return res;
  }

  Future<Either<Failure, AccountModel?>> login(
      {required LoginRequestModel model}) async {
    isLoginStatusOpen = false;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceModel = "";
    String paltform = "";
    if (kIsWeb) {
      paltform = "FlutterWeb";
      WebBrowserInfo androidInfo = await deviceInfo.webBrowserInfo;
      deviceModel = androidInfo.browserName.name;
    } else if (Platform.isAndroid) {
      paltform = "Android";
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
    } else if (Platform.isIOS) {
      paltform = "iOS";
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceModel = iosInfo.model;
    }
    final res = await networkOperation.create(
        errorMsg: Trans.loginFailed.trans(),
        showLoading: ShowLoading.show,
        successMsg: Trans.loginScucced.trans(),
        queryParameters: {
          "platform": paltform,
          "device": deviceModel,
        },
        parseBody: ParseBody.data,
        endPoint: EndPoints.login,
        logout: false,
        body: model.toMap(),
        showMessage: ShowMessage.failedToast,
        fromJsonModel: AccountModel.fromMap);

    return res;
  }

  Future<Either<Failure, UpdateAccountRep?>> updateToken({
    required String token,
  }) async {
    final res = await networkOperation.update(
        isForm: false,
        errorMsg: Trans.failedToUpdateToken.trans(),
        showLoading: ShowLoading.none,
        successMsg: Trans.successfullyUpdateToken.trans(),
        endPoint: EndPoints.updateFcmToken,
        body: {
          "fcm_token": token,
        },
        showMessage: ShowMessage.none,
        fromJsonModel: UpdateAccountRep.fromMap);

    return res;
  }

  Future signOut() async {
    await networkOperation.create<UnitModel>(
        errorMsg: Trans.logOut.trans(),
        showLoading: ShowLoading.none,
        successMsg: Trans.logOut.trans(),
        endPoint: EndPoints.logout,
        body: {},
        showMessage: ShowMessage.none,
        fromJsonModel: UnitModel.fromMap);
  }
}
