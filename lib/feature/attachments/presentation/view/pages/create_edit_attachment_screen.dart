import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/create_attachment_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';
import 'package:app/feature/attachments/presentation/blocs/all/attachments_bloc.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class CreateUpdateAttachmentScreen extends StatefulWidget {
  const CreateUpdateAttachmentScreen({super.key, required this.attachment});
  final AttachmentModel? attachment;
  @override
  State<CreateUpdateAttachmentScreen> createState() =>
      _CreateUpdateAttachmentScreenState();
}

class _CreateUpdateAttachmentScreenState
    extends State<CreateUpdateAttachmentScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.attachment?.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.attachment == null
                ? Trans.createArgs.trans(args: [Trans.attachments.trans()])
                : Trans.editArgs.trans(args: [Trans.attachments.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.attachment == null) {
                CreateAttachmentModel createAttachmentModel =
                    CreateAttachmentModel(name: name.text.trim());

                sl<AttachmentsBloc>()
                    .add(AttachmentCreateEvent(model: createAttachmentModel));
              } else {
                UpdateAttachmentModel createAttachmentModel =
                    UpdateAttachmentModel(
                        id: widget.attachment!.id, name: name.text.trim());
                sl<AttachmentsBloc>()
                    .add(AttachmentUpdateEvent(model: createAttachmentModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.attachments.trans())),
        body: ListView(
          children: [
            GeneralTextFiled(
                hintText: Trans.name.trans(),
                validate: validateName,
                controller: name)
          ],
        ));
  }
}
