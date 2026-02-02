import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/widgets/image.dart';
import 'package:app/widgets/image_cheker.dart';
import 'package:app/widgets/panorama.dart';
import 'package:flutter/material.dart';

class AttachmentWidget extends StatelessWidget {
  final AttachmentModel attachment;
  const AttachmentWidget({
    super.key,
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      // onLongPress: () {
      //   showOptionBottomSheet(options: [
      //     Options.View,
      //     Options.Edit,
      //     Options.Delete,
      //   ]).then((value) async {
      //     if (value == Options.View) {
      //       context.to(AttachmentDetailsScreen(
      //           id: attachment.id, name: attachment.title));
      //     } else if (value == Options.Edit) {
      //       context.to(CreateUpdateAttachmentScreen(attachment: attachment));
      //     } else if (value == Options.Delete) {
      //       final res = await getUserConfirm(
      //           desc: Trans.areYouSureYouWantToDeleteSelectedItem.trans());
      //       if (res == true) {
      //         sl<AttachmentsBloc>().add(AttachmentDeleteEvent(attachment));
      //       }
      //     }
      //   });
      // },
      onTap: () {
        if (attachment.fileType == FileType.Image && !attachment.is360) {
          context.to(ImageViewScreen(
              image: attachment.attachment, title: attachment.title));
        } else if (attachment.fileType == FileType.Image && attachment.is360) {
          context.to(PanoramaImage(
              url: attachment.attachment!, title: attachment.title));
        }
        // context.to(
        //     AttachmentDetailsScreen(id: attachment.id, name: attachment.title));
      },
      child: Container(
        padding: const EdgeInsets.all(kIndent),
        decoration: BoxDecoration(
            color: appConfig.app == App.rbb ? context.cardColor : null,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            if (attachment.is360)
              Assets.images.img360.image(width: 60, height: 60),
            if (attachment.fileType == FileType.Image && !attachment.is360)
              ImageChecker(
                  imageUrl: attachment.attachment, width: 60, height: 60),
            const SizedBox(width: 12),
            Text(
              attachment.title,
              style: context.style16W400B,
            ),
          ],
        ),
      ),
    );
  }
}
