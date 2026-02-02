part of "export.dart";

bool isLoginStatusOpen = false;
Future<void> loginStatusAlert(
    {String? title, required String desc, bool isAuth = false}) async {
  if (isLoginStatusOpen) {
    return;
  }
  isLoginStatusOpen = true;
  await failedAlert(body: desc, title: title ?? Trans.loginFalied.trans());
  isLoginStatusOpen = false;
  if (isAuth == true) {
    signOut(showConfirm: false);
  }
}
