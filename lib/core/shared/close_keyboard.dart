part of "imports.dart";

void closeKeyBoard(BuildContext context) {
  try {
    logger("closeKeyBoard is called");
    FocusScopeNode currentFocus = FocusScope.of(context);
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
      FocusManager.instance.primaryFocus?.unfocus();
      FocusScope.of(context).unfocus();
    }
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  } catch (e) {
    logger(e);
  }
}
