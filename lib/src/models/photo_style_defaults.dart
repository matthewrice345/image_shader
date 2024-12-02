import 'package:equatable/equatable.dart';

class HueBounds {
  static const double min = -0.05;
  static const double max = 0.05;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class SaturationBounds {
  static const double min = 0;
  static const double max = 2;
  static const double start = 1;
  static const Bounds bounds = Bounds(min, max, start);
}

class BrightnessBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class GammaBounds {
  static const double min = 0.25;
  static const double max = 1.75;
  static const double start = 1;
  static const Bounds bounds = Bounds(min, max, start);
}

class TemperatureBounds {
  static const double min = -1;
  static const double max = 1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class ContrastBounds {
  static const double min = 0;
  static const double max = 2;
  static const double start = 1;
  static const Bounds bounds = Bounds(min, max, start);
}

class HighlightsBounds {
  static const double min = -1;
  static const double max = 1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class BlacksBounds {
  static const double min = -0.75;
  static const double max = 0.75;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class WhitesBounds {
  static const double min = -0.75;
  static const double max = 0.75;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class ShadowsBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class ExposureBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class VibranceBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class ClarityBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class DehazeBounds {
  static const double min = -0.25;
  static const double max = 0.25;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class TintBounds {
  static const double min = -0.1;
  static const double max = 0.1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class SharpenBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class NoiseReductionBounds {
  static const double min = -0.5;
  static const double max = 0.5;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class VignetteBounds {
  static const double min = 0.5;
  static const double max = 1.5;
  static const double start = 0.5;
  static const Bounds bounds = Bounds(min, max, start);
}

class SepiaBounds {
  static const double min = -0.1;
  static const double max = 0.1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

//TODO: remove this, not really interesting
class InvertBounds {
  static const double min = 0;
  static const double max = 1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class GrayscaleBounds {
  static const double min = 0;
  static const double max = 1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

//TODO: remove this one
class PosterizeBounds {
  static const double min = -100;
  static const double max = 200;
  static const double start = 100;
  static const Bounds bounds = Bounds(min, max, start);
}

//TODO: remove this one
class BloomBounds {
  static const double min = 0;
  static const double max = 1;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class BlurBounds {
  static const double min = 0;
  static const double max = 10;
  static const double start = 0;
  static const Bounds bounds = Bounds(min, max, start);
}

class PhotoStyleBounds {
  static const Bounds hue = HueBounds.bounds;
  static const Bounds saturation = SaturationBounds.bounds;
  static const Bounds brightness = BrightnessBounds.bounds;
  static const Bounds gamma = GammaBounds.bounds;
  static const Bounds temperature = TemperatureBounds.bounds;
  static const Bounds contrast = ContrastBounds.bounds;
  static const Bounds highlights = HighlightsBounds.bounds;
  static const Bounds blacks = BlacksBounds.bounds;
  static const Bounds whites = WhitesBounds.bounds;
  static const Bounds shadows = ShadowsBounds.bounds;
  static const Bounds exposure = ExposureBounds.bounds;
  static const Bounds vibrance = VibranceBounds.bounds;
  static const Bounds clarity = ClarityBounds.bounds;
  static const Bounds dehaze = DehazeBounds.bounds;
  static const Bounds tint = TintBounds.bounds;
  static const Bounds sharpen = SharpenBounds.bounds;
  static const Bounds noiseReduction = NoiseReductionBounds.bounds;
  static const Bounds vignette = VignetteBounds.bounds;
  static const Bounds sepia = SepiaBounds.bounds;
  static const Bounds grayscale = GrayscaleBounds.bounds;
  static const Bounds blur = BlurBounds.bounds;
  static const (MinMax, MinMax, MinMax) colorBalance = (
    MinMax(min: 0.0, max: 2.0),
    MinMax(min: 0.0, max: 2.0),
    MinMax(min: 0.0, max: 2.0),
  );
}

class MinMax {
  final double min;
  final double max;

  const MinMax({required this.min, required this.max});

  @override
  String toString() {
    return 'MinMax(min: $min, max: $max)';
  }
}

class Bounds extends Equatable {
  const Bounds(this.min, this.max, this.start);
  final double min;
  final double max;
  final double start;

  static Bounds get none => Bounds(0, 0, 0);

  @override
  String toString() {
    return 'Bounds(min: $min, max: $max, start: $start)';
  }

  @override
  List<Object?> get props => [min, max, start];
}