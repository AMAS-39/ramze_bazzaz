part of "export.dart";

Future<void> failedAlert(
    {required String body, String? title, Function()? onOkClicked}) async {
  title ??= Trans.failed.trans();
  return await showDialog(
      context: Helper.i.context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 27, horizontal: 30),
          insetPadding: const EdgeInsets.all(kIndent),
          content: SizedBox(
            width: context.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  appConfig.logo,
                  width: 155,
                  height: 155,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.titleStyle.color),
                ),
                const SizedBox(height: 16),
                Text(body,
                    textAlign: TextAlign.center,
                    style: context.subTitleStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(height: 55),
                GeneralButton(
                  radius: 20,
                  fontSize: 14,
                  onTap: onOkClicked ??
                      () {
                        Navigator.pop(context);
                      },
                  text: Trans.ok.trans(),
                ),
              ],
            ),
          ),
        );
      });
}
