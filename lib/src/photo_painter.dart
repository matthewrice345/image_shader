import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:photo_shader/src/models/photo_style.dart';

class PhotoPainter extends CustomPainter {
  const PhotoPainter({
    required this.shader,
    required this.image,
    required this.style,
  });

  final ui.FragmentShader shader;
  final ui.Image image;
  final PhotoStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setImageSampler(0, image);

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    shader.setFloat(2, style.brightness);
    shader.setFloat(3, style.saturation);
    shader.setFloat(4, style.hue);
    shader.setFloat(5, style.gamma);
    shader.setFloat(6, style.temperature);
    shader.setFloat(7, style.contrast);
    shader.setFloat(8, style.highlights);
    shader.setFloat(9, style.blacks);
    shader.setFloat(10, style.whites);
    shader.setFloat(11, style.shadows);
    shader.setFloat(12, style.exposure);
    shader.setFloat(13, style.vibrance);
    shader.setFloat(14, style.clarity);
    shader.setFloat(15, style.dehaze);
    shader.setFloat(16, style.tint);
    shader.setFloat(17, style.sharpen);
    shader.setFloat(18, style.noiseReduction);
    shader.setFloat(19, style.vignette);
    shader.setFloat(20, style.sepia);
    shader.setFloat(21, style.grayscale);
    shader.setFloat(22, style.colorBalance.r);
    shader.setFloat(23, style.colorBalance.g);
    shader.setFloat(24, style.colorBalance.b);


    final paint = Paint()..shader = shader;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant PhotoPainter oldDelegate) {
    return style != oldDelegate.style || image != oldDelegate.image;
  }
}
