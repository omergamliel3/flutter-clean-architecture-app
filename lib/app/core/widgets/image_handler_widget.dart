import 'package:flutter/material.dart';

import '../assets/constans.dart';

import 'index.dart';

class ImageHandlerWidget extends StatelessWidget {
  final double targetHeight;
  final String url;
  const ImageHandlerWidget({@required this.targetHeight, @required this.url});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          child: FadeInImage.assetNetwork(
            height: targetHeight,
            width: double.infinity,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: loadingAsset,
            image: url,
            imageErrorBuilder: (context, obj, error) => AssetImageWidget(
              targetHeight: targetHeight,
            ),
          )),
    );
  }
}
