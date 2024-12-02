import 'package:equatable/equatable.dart';

class RGB extends Equatable {
  const RGB(this.r, this.g, this.b);

  const RGB.normal() : r = 1, g = 1, b = 1;

  final double r;
  final double g;
  final double b;

  RGB copyWith({
    double? r,
    double? g,
    double? b,
  }) {
    return RGB(
      r ?? this.r,
      g ?? this.g,
      b ?? this.b,
    );
  }

  @override
  List<Object?> get props => [r, g, b];
}
