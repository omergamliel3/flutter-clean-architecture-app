import 'package:flutter/material.dart';

import '../assets/constans.dart';

import 'index.dart';

class ImageHandlerWidget extends StatelessWidget {
  final String urlToImage;
  const ImageHandlerWidget({@required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 500),
              placeholder: loadingAsset,
              image: urlToImage,
              imageErrorBuilder: (context, obj, error) => AssetImageWidget(),
            ),
          )),
    );
  }
}
