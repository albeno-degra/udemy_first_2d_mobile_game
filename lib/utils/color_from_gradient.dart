import 'package:flutter/material.dart';

Color colorFromGradient({
  required LinearGradient gradient,
  required Size size,
  required Offset point,
}) {
  final rect = Offset.zero & size;
  final begin = gradient.begin.resolve(TextDirection.ltr).withinRect(rect);
  final end = gradient.end.resolve(TextDirection.ltr).withinRect(rect);
  final direction = end - begin;
  final lengthSquared =
      direction.dx * direction.dx + direction.dy * direction.dy;

  if (lengthSquared == 0) {
    return gradient.colors.last;
  }

  final projection = ((point.dx - begin.dx) * direction.dx +
          (point.dy - begin.dy) * direction.dy) /
      lengthSquared;

  final t = projection.clamp(0.0, 1.0);

  final stops = gradient.stops ??
      List.generate(
        gradient.colors.length,
        (i) => i / (gradient.colors.length - 1),
      );

  for (int i = 0; i < stops.length - 1; i++) {
    final start = stops[i];

    final end = stops[i + 1];

    if (t >= start && t <= end) {
      final localT = (t - start) / (end - start);

      return Color.lerp(
        gradient.colors[i],
        gradient.colors[i + 1],
        localT,
      )!;
    }
  }

  return gradient.colors.last;
}
