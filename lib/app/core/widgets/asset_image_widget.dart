import 'package:flutter/material.dart';
import '../assets/constans.dart';

class AssetImageWidget extends StatelessWidget {
  final double targetHeight;
  const AssetImageWidget({@required this.targetHeight});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      placeholderAsset,
      height: targetHeight,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
