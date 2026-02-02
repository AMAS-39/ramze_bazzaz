part of "export.dart";

Future<void> permissionNotAllowedAlert(
    {required String error, String? title, Function()? onTap}) async {
  return await showDialog(
      context: Helper.i.context,
      builder: (context) {
        return AlertDialog(
            title: Text((title ?? ""), style: context.titleStyle),
            content: Text(error,
                style: context.subTitleStyle.copyWith(fontSize: 16)),
            actions: [
              TextButton(
                child: Text(Trans.allow.trans()),
                onPressed: () {
                  Navigator.pop(context, true);
                  onTap?.call();
                },
              ),
              TextButton(
                child: Text(
                  Trans.ignore.trans(),
                  style: TextStyle(color: context.subTitleStyle.color),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))));
      });
}
