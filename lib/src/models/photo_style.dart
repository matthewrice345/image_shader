import 'package:equatable/equatable.dart';
import 'package:photo_shader/photo_shader.dart';

class PhotoStyle extends Equatable {
  const PhotoStyle({
    required this.hue,
    required this.saturation,
    required this.brightness,
    required this.gamma,
    required this.temperature,
    required this.contrast,
    required this.highlights,
    required this.blacks,
    required this.whites,
    required this.shadows,
    required this.exposure,
    required this.vibrance,
    required this.clarity,
    required this.dehaze,
    required this.tint,
    required this.sharpen,
    required this.noiseReduction,
    required this.vignette,
    required this.sepia,
    required this.grayscale,
    required this.colorBalance,
  });

  PhotoStyle.noEffects()
      : this(
          hue: PhotoStyleBounds.hue.start,
          saturation: PhotoStyleBounds.saturation.start,
          brightness: PhotoStyleBounds.brightness.start,
          gamma: PhotoStyleBounds.gamma.start,
          temperature: PhotoStyleBounds.temperature.start,
          contrast: PhotoStyleBounds.contrast.start,
          highlights: PhotoStyleBounds.highlights.start,
          blacks: PhotoStyleBounds.blacks.start,
          whites: PhotoStyleBounds.whites.start,
          shadows: PhotoStyleBounds.shadows.start,
          exposure: PhotoStyleBounds.exposure.start,
          vibrance: PhotoStyleBounds.vibrance.start,
          clarity: PhotoStyleBounds.clarity.start,
          dehaze: PhotoStyleBounds.dehaze.start,
          tint: PhotoStyleBounds.tint.start,
          sharpen: PhotoStyleBounds.sharpen.start,
          noiseReduction: PhotoStyleBounds.noiseReduction.start,
          vignette: PhotoStyleBounds.vignette.start,
          sepia: PhotoStyleBounds.sepia.start,
          grayscale: PhotoStyleBounds.grayscale.start,
          colorBalance: const RGB.normal(),
        );

  final double hue;
  final double saturation;
  final double brightness;
  final double gamma;
  final double temperature;
  final double contrast;
  final double highlights;
  final double blacks;
  final double whites;
  final double shadows;
  final double exposure;
  final double vibrance;
  final double clarity;
  final double dehaze;
  final double tint;
  final double sharpen;
  final double noiseReduction;
  final double vignette;
  final double sepia;
  final double grayscale;
  final RGB colorBalance;

  PhotoStyle copyWith({
    double? hue,
    double? saturation,
    double? brightness,
    double? gamma,
    double? temperature,
    double? contrast,
    double? highlights,
    double? blacks,
    double? whites,
    double? shadows,
    double? exposure,
    double? vibrance,
    double? clarity,
    double? dehaze,
    double? tint,
    double? sharpen,
    double? noiseReduction,
    double? vignette,
    double? sepia,
    double? grayscale,
    RGB? colorBalance,
  }) {
    return PhotoStyle(
      hue: hue ?? this.hue,
      saturation: saturation ?? this.saturation,
      brightness: brightness ?? this.brightness,
      gamma: gamma ?? this.gamma,
      temperature: temperature ?? this.temperature,
      contrast: contrast ?? this.contrast,
      highlights: highlights ?? this.highlights,
      blacks: blacks ?? this.blacks,
      whites: whites ?? this.whites,
      shadows: shadows ?? this.shadows,
      exposure: exposure ?? this.exposure,
      vibrance: vibrance ?? this.vibrance,
      clarity: clarity ?? this.clarity,
      dehaze: dehaze ?? this.dehaze,
      tint: tint ?? this.tint,
      sharpen: sharpen ?? this.sharpen,
      noiseReduction: noiseReduction ?? this.noiseReduction,
      vignette: vignette ?? this.vignette,
      sepia: sepia ?? this.sepia,
      grayscale: grayscale ?? this.grayscale,
      colorBalance: colorBalance ?? this.colorBalance,
    );
  }

  @override
  List<Object> get props => [
        hue,
        saturation,
        brightness,
        gamma,
        temperature,
        contrast,
        highlights,
        blacks,
        whites,
        shadows,
        exposure,
        vibrance,
        clarity,
        dehaze,
        tint,
        sharpen,
        noiseReduction,
        vignette,
        sepia,
        grayscale,
        colorBalance,
      ];
}
