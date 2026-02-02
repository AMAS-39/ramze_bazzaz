import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/widgets/image_cheker.dart';
import 'package:flutter/material.dart';

class SlideWidget extends StatelessWidget {
  final SlideModel slide;
  final ValueNotifier<double> aspectRatio;

  const SlideWidget({
    super.key,
    required this.slide,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // onLongPress: () {
        //   showOptionBottomSheet(options: [
        //     Options.View,
        //     Options.Edit,
        //     Options.Delete,
        //   ]).then((value) async {
        //     if (value == Options.View) {
        //       context
        //           .to(SlideDetailsScreen(id: slide.id, name: slide.name ?? ""));
        //     } else if (value == Options.Edit) {
        //       context.to(CreateUpdateSlideScreen(slide: slide));
        //     } else if (value == Options.Delete) {
        //       final res = await getUserConfirm(
        //           desc: Trans.areYouSureYouWantToDeleteSelectedItem.trans());
        //       if (res == true) {
        //         sl<SlidesBloc>().add(SlideDeleteEvent(slide));
        //       }
        //     }
        //   });
        // },
        // onTap: () {
        //   context.to(SlideDetailsScreen(id: slide.id, name: slide.name ?? ""));
        // },
        child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Flexible(
            child: ImageChecker(
              imageUrl: slide.attachment,
              onLoad: (height) {
                if (height.width! / height.height! < aspectRatio.value) {
                  aspectRatio.value = height.width! / height.height!;
                }
              },
              fit: BoxFit.cover,
              width: context.width,
              height: context.width,
              memCacheWidth: (context.width * 1.5).toInt(),
              radius: 8,
            ),
          ),

          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         Colors.transparent,
          //         Colors.black.withOpacity(0.3),
          //       ],
          //     ),
          //   ),
          // ),

          // Text Content
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: const EdgeInsets.all(24.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           slide.name ?? "",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
