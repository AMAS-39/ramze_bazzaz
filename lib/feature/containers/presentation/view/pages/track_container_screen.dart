import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/views/ios_webview.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class TrackContainerScreen extends StatefulWidget {
  const TrackContainerScreen({super.key});

  @override
  State<TrackContainerScreen> createState() => _TrackContainerScreenState();
}

class _TrackContainerScreenState extends State<TrackContainerScreen> {
  void onSearch(String id) {
    setState(() {});
  }

  final TextEditingController controller = TextEditingController();

  Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(Trans.containers.trans())),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: GeneralTextFiled(
                onChange: (p0) {
                  debouncer.run(() {
                    onSearch(p0);
                  });
                },
                hintText: Trans.searchHere.trans(),
                controller: controller),
          ),
          Expanded(child: Builder(
            builder: (context) {
              if (controller.text.isEmpty || controller.text.trim().isEmpty) {
                return SizedBox();
              }
              return AppWebView(trackNumber: controller.text);
            },
          )),
        ],
      ),
    );
  }
}
