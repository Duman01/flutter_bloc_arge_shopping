import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class customText extends StatelessWidget {

  String label;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  AlignmentGeometry alignment;
  int maxLines;
  FontStyle fontStyle;
  int padding;

  customText({this.label,this.fontSize,this.fontWeight,this.color,this.alignment,this.maxLines,this.fontStyle,this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(padding??2),
      child: AutoSizeText(
        "$label",
        maxLines: maxLines??1,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: fontSize??11,
            fontWeight: fontWeight,
            color: color??null,
            fontStyle: fontStyle??null,
        ),
      ),
    );
  }
}