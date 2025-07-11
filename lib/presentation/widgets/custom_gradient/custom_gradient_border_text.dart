import 'package:flutter/material.dart';


import '../../../common/constants/colors.dart';

class CustomGradientBorderText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final List<BoxShadow>? shadow;
  final List<Color> gradientColors;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final double? strokeWidth;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomGradientBorderText(
      {super.key,
      required this.text,
      required this.style,
      this.shadow,
      this.gradientColors = const [
        AppColors.green,
        AppColors.grey,
      ],
      this.textAlign,
      this.fontStyle = FontStyle.italic,
      this.strokeWidth,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: shadow,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            maxLines: maxLines,
            overflow: overflow,
            style: style.copyWith(
              wordSpacing: 1.1,
              fontStyle: fontStyle,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth ?? (style.fontSize ?? 16) * 0.33
                ..strokeJoin = StrokeJoin.round
                ..shader = LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: List.generate(
                    gradientColors.length,
                    (index) => index / (gradientColors.length - 1),
                  ),
                  colors: gradientColors,
                ).createShader(
                  Rect.fromLTWH(0, 0, textWidth, textHeight),
                ),
            ),
            textAlign: textAlign,
          ),
          Text(
            text,
            style: style.copyWith(
              fontStyle: fontStyle,
              wordSpacing: 1.1,
            ),
            textAlign: textAlign,
          ),
        ],
      ),
    );
  }
}
