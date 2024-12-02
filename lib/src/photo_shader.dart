import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:photo_shader/src/constants/shader_path.dart';
import 'package:photo_shader/src/photo_painter.dart';
import 'package:photo_shader/src/models/photo_style.dart';

typedef FragmentPath = String;

class PhotoShader extends StatefulWidget {
  const PhotoShader({
    super.key,
    required this.style,
    required this.imageProvider,
    required this.image,
    this.fadeDuration = const Duration(milliseconds: 500),
  }) : assert(imageProvider != null || image != null, 'Either imageProvider or image must be provided');

  const PhotoShader.provider({
    super.key,
    required this.style,
    required ImageProvider this.imageProvider,
    Duration? fadeDuration,
  }) : image = null, fadeDuration = fadeDuration ?? const Duration(milliseconds: 500);

  const PhotoShader.image({
    super.key,
    required this.style,
    required ui.Image this.image,
    Duration? fadeDuration,
  }) : imageProvider = null, fadeDuration = fadeDuration ?? const Duration(milliseconds: 500);

  final PhotoStyle style;
  final ImageProvider? imageProvider;
  final ui.Image? image;
  final Duration fadeDuration;

  @override
  State<PhotoShader> createState() => _PhotoShaderState();
}

class _PhotoShaderState extends State<PhotoShader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Completer<ui.Image> _imageCompleter;
  ui.Image? _image;
  bool _canAnimate = true;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    _imageCompleter = Completer<ui.Image>();

    _controller = AnimationController(
      duration: widget.fadeDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (_image == null) {
      _loadImage();
    } else {
      _imageCompleter.complete(_image);
      _fadeInImage();
    }
  }

  @override
  void didUpdateWidget(covariant PhotoShader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageProvider != null && widget.imageProvider != oldWidget.imageProvider) {
      // rebuild the image
      _canAnimate = true;
      _loadImage();
    }
  }

  void _loadImage() {
    if (_imageCompleter.isCompleted) {
      _imageCompleter = Completer<ui.Image>();
    }
    widget.imageProvider!.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        _imageCompleter.complete(info.image);
        if (_image == null) {
          _image = info.image;
          _fadeInImage();
        } else {
          _image = info.image;
          _fadeInImage();
        }
      }),
    );
  }

  void _fadeInImage() {
    // only go forward if we are not already there.
    if(_canAnimate) {
      _canAnimate = false;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      return FadeTransition(
        opacity: _animation,
        child: _PhotoShaderBuilder(
          image: _image!,
          style: widget.style,
        ),
      );
    }

    return FutureBuilder<ui.Image>(
      future: _imageCompleter.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FadeTransition(
            opacity: _animation,
            child: _PhotoShaderBuilder(
              image: snapshot.data!,
              style: widget.style,
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class _PhotoShaderBuilder extends StatelessWidget {
  const _PhotoShaderBuilder({required this.image, required this.style});

  final ui.Image image;
  final PhotoStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: ShaderPath.externalUsageShaderPath,
      (context, shader, _) {
        return CustomPaint(
          isComplex: true,
          willChange: true,
          painter: PhotoPainter(
            shader: shader,
            image: image,
            style: style,
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: image.width.toDouble(),
              height: image.height.toDouble(),
            ),
          ),
        );
      },
    );
  }
}
