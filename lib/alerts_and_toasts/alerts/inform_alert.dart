part of "export.dart";

Future<bool?> showMessageDialog({
  required String title,
  required String msg,
}) async {
  return await showDialog<bool?>(
      context: Helper.i.context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 18),
            ),
            content: Text(
              msg,
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                child: Text(Trans.ok.trans().toUpperCase()),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
            elevation: 9,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))));
      });
}
