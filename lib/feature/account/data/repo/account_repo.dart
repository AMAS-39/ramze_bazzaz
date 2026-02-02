import 'dart:async';

import 'package:app/core/network_checker/connection_checker.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/datasources/account_local_data_source.dart';
import 'package:app/feature/account/data/datasources/account_remote_data_source.dart';
import 'package:app/feature/account/data/model/account_model.dart';
import 'package:app/feature/account/data/model/change_account_info_model.dart';
import 'package:app/feature/account/data/model/change_password_model.dart';
import 'package:app/feature/account/data/model/customer_info_model.dart';
import 'package:app/feature/account/data/model/register_model.dart';
import 'package:app/feature/account/data/model/update_account_reposne.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';

class AccountRepo {
  late AccountRemoteSrc accountRemoteSrc;
  late AccountLocalSrc localAccountSrc;
  final ConnectionChecker connectionChecker;
  AccountRepo(
      {required this.connectionChecker,
      required this.accountRemoteSrc,
      required this.localAccountSrc});
  Future<Either<Failure, AccountModel?>> fromLocal() async {
    return localAccountSrc.getAccountModel();
  }

  Future<Either<Failure, CustomerInfoModel?>> getCustomerInfoFromLocal() async {
    return localAccountSrc.getCustomerInfo();
  }

  Future<Either<Failure, UnitModel?>> requestDeleteAccount({
    required Map<String, dynamic> params,
    required ShowMessage showMessage,
    required ShowLoading showLoading,
  }) async {
    final res = await accountRemoteSrc.requestDeleteAccount(
        params: params, showMessage: showMessage, showLoading: showLoading);
    // if (res.isRight()) {
      await localAccountSrc.clearAll();
    // }
    return res;
  }

  Future<Either<Failure, AccountModel?>> login(
      {required AccountLoginEvent event}) async {
    final res = await accountRemoteSrc.login(model: event.loginModel);
    final moodel = res.getRight(() => null);
    if (moodel != null) {
      await saveLoginModel(moodel);
    await localAccountSrc.saveAccountListModel(event.loginModel);
    }
    return res;
  }

  Future<Either<Failure, CustomerInfoModel?>> getInfo() async {
    final res = await accountRemoteSrc.getCustomerInfo();
    final moodel = res.getRight(() => null);
    if (moodel != null) {
      await saveCustomerInfoModel(moodel);
    }
    return res;
  }

  Future<void> saveLoginModel(AccountModel account) async {
    await localAccountSrc.saveAccountModel(account);
  }

  Future<void> saveCustomerInfoModel(CustomerInfoModel account) async {
    await localAccountSrc.saveCustomerInfo(account);
  }

  Future<Either<Failure, UpdateAccountRep?>> updateAccountInfo(
      ChangeAccountInfo account) async {
    final res = await accountRemoteSrc.updateUser(
        loginModel: account, showLoading: ShowLoading.show);
    if (res.isRight()) {}
    return res;
  }

  Future<Either<Failure, UnitModel?>> changePassword(
      ChangePasswordModel account) async {
    final res = await accountRemoteSrc.changePassword(
        changePassword: account, showLoading: ShowLoading.show);

    return res;
  }

  Future signOut() async {
    await localAccountSrc.clearAll();
  }

  Future<Either<Failure, UnitModel?>> register({
    required RegisterModel registerModel,
    required ShowLoading showLoading,
  }) async {
    return await accountRemoteSrc.register(
        loginModel: registerModel, showLoading: showLoading);
  }
}
