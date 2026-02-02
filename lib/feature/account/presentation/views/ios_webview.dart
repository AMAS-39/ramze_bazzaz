import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({super.key, required this.trackNumber});
  final String trackNumber;
  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  InAppWebViewController? controller;

  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
        key: webViewKey,
        initialSettings: InAppWebViewSettings(useHybridComposition: false),
        onWebViewCreated: (cccontroller) async {
          controller = cccontroller;
        },
        initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse(
              "${appConfig.url}/Containers/${widget.trackNumber}/Track")),
        ));
  }
}
