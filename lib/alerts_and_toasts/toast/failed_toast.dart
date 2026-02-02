part of "export_toast.dart";

Future<void> showFailedFlashBar(String message) async {
  showSimpleNotification(
      Text(message,
          style:
              const TextStyle(fontSize: 14, height: 1.5, color: Colors.white)),
      autoDismiss: true,
      elevation: 0,
      // key: ValueKey(message),
      duration: const Duration(seconds: 3),
      slideDismissDirection: DismissDirection.vertical,
      leading: const Icon(Icons.error, size: 28.0, color: Colors.red),
      background: const Color(0xFF303030));
}
