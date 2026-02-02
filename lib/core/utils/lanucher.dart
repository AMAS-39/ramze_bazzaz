import 'package:app/alerts_and_toasts/toast/toast.dart';
import 'package:app/core/shared/imports.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openEmail(String? phone) async {
  if (checkIsNull(phone)) {
    return;
  }
  Uri uri = Uri.parse('mailto:$phone');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showToast(Trans.failed.trans());
  }
}
Future<void> openPhoneCall(String? phone) async {
  if (checkIsNull(phone)) {
    return;
  }
  Uri uri = Uri.parse('tel:$phone');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showToast(Trans.failed.trans());
  }
}

Future<void> openUrl(String? url) async {
  if (checkIsNull(url)) {
    return;
  }
  Uri uri = Uri.parse(url!);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    showToast(Trans.operationFailedUnKnownError.trans());
  }
}
