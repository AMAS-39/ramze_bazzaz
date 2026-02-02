part of "export_toast.dart";

Future<void> showSuccessFlashBar(String message) async {
  showSimpleNotification(
      Text(message,
          style:
              const TextStyle(fontSize: 14, height: 1.5, color: Colors.white)),
      autoDismiss: true,
      elevation: 0,
      duration: const Duration(seconds: 3),
      slideDismissDirection: DismissDirection.vertical,
      leading: const Icon(Icons.check_circle_outline_outlined,
          size: 28.0, color: Colors.green),
      background: const Color(0xFF303030));
}
