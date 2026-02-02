import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen(
      {super.key,
      required this.image,
      required this.title,
      this.isFile = false});
  final String? image;
  final String title;
  final bool isFile;
  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: PhotoView(
              loadingBuilder: (t, ImageChunkEvent? p) {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                );
              },
              imageProvider: CachedNetworkImageProvider(
                widget.image!,
              ))),
    );
  }
}
