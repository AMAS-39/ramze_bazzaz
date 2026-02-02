part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object> get props => [];
}

class AccountLogoutEvent extends AccountEvent {
  const AccountLogoutEvent(
    {
      required this.showConfirm
    }
  );
  final bool showConfirm;
  @override
  List<Object> get props => [];
}
class AccountDeleteEvent extends AccountEvent {
  const AccountDeleteEvent();

  @override
  List<Object> get props => [];
}
class AccountFromLocalEvent extends AccountEvent {
  const AccountFromLocalEvent();
  @override
  List<Object> get props => [];
}

class AccountSetEvent extends AccountEvent {
  const AccountSetEvent(this.data);
  final AccountModel data;
  @override
  List<Object> get props => [];
}

class AccountUpdateEvent extends AccountEvent {
  const AccountUpdateEvent(
    this.account,
  );
  final ChangeAccountInfo account;
  @override
  List<Object> get props => [];
}

class AccountLoginEvent extends AccountEvent {
  const AccountLoginEvent({
    required this.loginModel,
    required this.dataSource,
    required this.isSelected,
  });
  final LoginRequestModel loginModel;
  final DataSource dataSource;
  final bool isSelected;
  @override
  List<Object> get props => [loginModel];
}
