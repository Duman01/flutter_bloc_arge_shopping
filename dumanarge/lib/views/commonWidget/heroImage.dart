import 'package:flutter/material.dart';

class heroImage extends StatefulWidget {
  String url;
  String tag;
  heroImage({this.url,this.tag});
  @override
  _heroImageState createState() => _heroImageState();
}

class _heroImageState extends State<heroImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${widget.tag}',
      child: FadeInImage(
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: 200),
        fadeOutDuration: Duration(milliseconds: 200),
        placeholder: AssetImage("assets/images/loading.gif"),
        image: NetworkImage(widget.url),
      ),
    );
  }
}