// ignore_for_file: use_build_context_synchronously

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/model/account_model.dart';
import 'package:app/feature/account/data/model/change_account_info_model.dart';
import 'package:app/feature/account/data/model/login_model.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/startup/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_status.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepo repository;
  AccountBloc({required this.repository}) : super(AccountInitial()) {
    on<AccountFromLocalEvent>(_onLocal);
    on<AccountLoginEvent>(_onRemote);
    on<AccountSetEvent>(_onLoginSetEvent);
    on<AccountUpdateEvent>(_onLoginUpdateEvent);
    on<AccountLogoutEvent>(signOut);
    on<AccountDeleteEvent>(_onAccountDeleteEvent);
  }
  Future<void> _onLoginUpdateEvent(
      AccountUpdateEvent event, Emitter<AccountState> emit) async {
    final res = await repository.updateAccountInfo(event.account);
    if (res.isRight()) {
      emit(AccountLoadedState(data: info!.copyWith()));
    }
  }

  Future<void> _onLoginSetEvent(AccountSetEvent event, Emitter<AccountState> emit) async {
    logger("event.data ${event.data}");
    repository.saveLoginModel(event.data);
    emit(AccountLoadedState(data: event.data));
  }

  Future<Either<Failure, AccountModel?>> _onLocal(AccountFromLocalEvent event, Emitter<AccountState> emit) async {
    final result = await repository.fromLocal();

    result.fold(
      (failure) => emit(AccountErrorState(failure: failure)),
      (data) {
        emit(_mapPropsToState(data));
        // Helper.i.context.toAndRemove(const SplashScreen());
      },
    );
    logger(state);
    return result;
  }

  Future<void> _onAccountDeleteEvent(
      AccountDeleteEvent event, Emitter<AccountState> emit) async {
    final confirm =
        await getUserConfirm(desc: Trans.areYouSureYouWantToSubmit.trans());
    if (confirm != true) {
      return;
    }
    final res = await repository.requestDeleteAccount(
      params: {},
      showLoading: ShowLoading.show,
      showMessage: ShowMessage.none,
    );
    logger("res $res");
    // if (res.isRight()) {
    emit(AccountInitial());
    await repository.signOut();
    Helper.i.context.toAndRemove(const SplashScreen());
    // }
  }

  Future<Either<Failure, AccountModel?>> _onRemote(AccountLoginEvent event, Emitter<AccountState> emit) async {
    final result = await repository.login(event: event);
    result.fold(
      (failure) => emit(AccountErrorState(failure: failure)),
      (data) {
        emit(_mapPropsToState(data));
        if (event.isSelected) {
          Helper.i.context.toAndRemove(const SplashScreen());
        }
      },
    );
    logger(state);
    return result;
  }

  String get getUserSeries => info!.id;

  AccountModel? get info {
    if (state is AccountLoadedState) {
      return (state as AccountLoadedState).data;
    }
    return null;
  }

  AccountState _mapPropsToState(AccountModel? entities) {
    return entities == null
        ? const AccountEmptyState()
        : AccountLoadedState(data: entities);
  }

  Future<void> signOut(AccountLogoutEvent event, Emitter<AccountState> emit) async {
    if (event.showConfirm) {
      final confirm =
          await getUserConfirm(desc: Trans.areYouSureToLogOut.trans());
      if (confirm != true) {
        return;
      }
    }
    emit(AccountInitial());
    await repository.signOut();
    Navigator.pushAndRemoveUntil(
        Helper.i.context,
        MaterialPageRoute(builder: (_) => const SplashScreen()),
        (route) => false);
  }
}
