import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  final double height;
  logo({this.height});

  @override
  Widget build(BuildContext context) {
    var assetImage = AssetImage('assets/images/eshop.png');
    var image = Image(
      image: assetImage,
      height: height??30,
    );
    return Container(
      child: image,
    );
  }
}
