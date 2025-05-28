import 'package:flutter/material.dart';

class CustomGradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomGradientText(this.text, {super.key, required this.style, required this.gradient, this.textAlign, this.maxLines, this.overflow = TextOverflow.visible});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white, height: 1.5),
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}
