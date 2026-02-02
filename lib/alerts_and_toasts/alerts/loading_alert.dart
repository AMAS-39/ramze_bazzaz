part of "export.dart";

Future<void> showLoadingProgressAlert() async {
  showDialog<void>(
    context: Helper.i.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
          canPop: false,
          child: Center(
            child: SizedBox(
              child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)),
            ),
          ));
    },
  );
}
