import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

enum AngleQuadrant { topRight, topLeft, bottomLeft, bottomRight }

AngleQuadrant getAngleQuadrant(double angle) {
  if (angle >= 0 && angle < pi / 2) {
    return AngleQuadrant.topRight;
  } else if (angle >= pi / 2 && angle < pi) {
    return AngleQuadrant.bottomRight;
  } else if (angle >= -pi && angle < -pi / 2) {
    return AngleQuadrant.bottomLeft;
  } else {
    return AngleQuadrant.topLeft;
  }
}

AngleQuadrant getPositionQuadrant(Vector2 position, Offset center) {
  final isLeft = position.x < center.dx;

  final isTop = position.y < center.dy;

  if (isLeft && isTop) return AngleQuadrant.topLeft;

  if (!isLeft && isTop) return AngleQuadrant.topRight;

  if (isLeft && !isTop) return AngleQuadrant.bottomLeft;

  return AngleQuadrant.bottomRight;
}
