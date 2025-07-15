import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.data, {
    super.key,
    this.textAlign,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.style,
    this.height,
    this.letterSpacing,
  });

  final String data;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextStyle? style;
  final double? height;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: key,
      style: style ??
          GoogleFonts.dmSans(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
            letterSpacing: letterSpacing,
          ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textScaler: textScaler,
    );
  }
}
class SvgIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;

  const SvgIcon(this.path, {super.key, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          height: size,
          width: size,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ));
  }
}
