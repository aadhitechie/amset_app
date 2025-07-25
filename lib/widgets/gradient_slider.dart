library gradient_slider;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradientSlider extends StatefulWidget {
  final String? thumbAsset;
  final Widget slider;
  final int thumbWidth;
  final int thumbHeight;
  final double? trackHeight;
  final Gradient? activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final Color? inactiveTrackColor;
  final double? trackBorder;
  final SliderComponentShape? thumbShape;

  final Color? trackBorderColor;
  final Radius? trackRadius;

  const GradientSlider(
      {super.key,
      this.thumbAsset,
      required this.slider,
      this.activeTrackGradient,
      this.thumbWidth = 50,
      this.thumbHeight = 50,
      this.trackHeight,
      this.inactiveTrackColor,
      this.inactiveTrackGradient,
      this.trackBorder,
      this.trackBorderColor,
      this.thumbShape,
      this.trackRadius});

  @override
  State<GradientSlider> createState() => _GradientSliderState();
}

class _GradientSliderState extends State<GradientSlider> {
  ImageThumbShape? myShape;

  @override
  void initState() {
    super.initState();
    if (widget.thumbAsset != null) {
      _loadImage();
    }
  }

  _loadImage() async {
    ByteData byData = await rootBundle.load(widget.thumbAsset!);
    final Uint8List bytes = Uint8List.view(byData.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: widget.thumbWidth, targetHeight: widget.thumbHeight);
    ui.Image image = (await codec.getNextFrame()).image;
    myShape = ImageThumbShape(image: image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: widget.thumbAsset != null ? myShape : widget.thumbShape,
        trackHeight: widget.trackHeight,
        inactiveTrackColor: widget.inactiveTrackColor,
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: GradientSliderTrackShape(
            activeTrackGradient:
                widget.activeTrackGradient ?? _defaultAciveGradient,
            inactiveTrackGradient: widget.inactiveTrackGradient,
            trackBorder: widget.trackBorder,
            trackBorderColor: widget.trackBorderColor,
            trackRadius: widget.trackRadius),
      ),
      child: widget.slider,
    );
  }

  final _defaultAciveGradient =
      const LinearGradient(colors: [Colors.red, Colors.blue]);
}

class GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  GradientSliderTrackShape({
    required this.activeTrackGradient,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackBorderColor,
    this.trackRadius,
  });
  final Gradient activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final double? trackBorder;
  final Color? trackBorderColor;
  final Radius? trackRadius;
  @override
  void paint(
    PaintingContext context,
    ui.Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required ui.TextDirection textDirection,
    required ui.Offset thumbCenter,
    ui.Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Rect activeTrackRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor, end: Colors.white);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: inactiveTrackGradient != null
            ? Colors.white
            : sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..shader = activeTrackGradient.createShader(activeTrackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    if (inactiveTrackGradient != null) {
      inactivePaint.shader = inactiveTrackGradient!.createShader(trackRect);
    }
    final canvas = context.canvas;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius =
        this.trackRadius ?? Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = this.trackRadius ??
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
    if (trackBorder != null || trackBorderColor != null) {
      final strokePaint = Paint()
        ..color = trackBorderColor ?? Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackBorder != null
            ? trackBorder! < trackRect.height / 2
                ? trackBorder!
                : trackRect.height / 2
            : 1
        ..strokeCap = StrokeCap.round;
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
              trackRect.left, trackRect.top, trackRect.right, trackRect.bottom,
              topLeft: trackRadius,
              bottomLeft: trackRadius,
              bottomRight: trackRadius,
              topRight: trackRadius),
          strokePaint);
    }
  }
}

class ImageThumbShape extends SliderComponentShape {
  ui.Image image;

  ImageThumbShape({required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;
    Offset imageOffset =
        Offset(center.dx - (imageWidth / 2), center.dy - (imageHeight / 2));
    Paint paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, imageOffset, paint);
  }
}
