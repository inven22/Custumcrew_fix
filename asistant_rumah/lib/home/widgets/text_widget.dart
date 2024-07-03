import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatefulWidget {
  final String text;
  final double letterSpace;
  double size = 5.0;
  FontWeight fontWeight = FontWeight.normal;
  final Color color;

  TextWidget(this.text, this.size, this.color, this.fontWeight,
      {super.key, this.letterSpace = 3});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          color: widget.color,
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
          letterSpacing: widget.letterSpace),
    );
  }
}
