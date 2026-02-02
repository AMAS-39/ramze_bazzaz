import 'package:flutter/material.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';

class AttachmentDetailsWidget extends StatefulWidget {
  final AttachmentDetailsModel attachment;

  const AttachmentDetailsWidget({super.key, required this.attachment});

  @override
  State<AttachmentDetailsWidget> createState() {
    return _AttachmentDetailsWidgetState();
  }
}

class _AttachmentDetailsWidgetState extends State<AttachmentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
