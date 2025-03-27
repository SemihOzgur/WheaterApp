import 'package:flutter/material.dart';

class MyGif extends StatelessWidget {
  MyGif({
    super.key,
    required this.path,
    required this.width,
    required this.height,
  });
  String path;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(path),
      width: width,
      height: height,
    );
  }
}
