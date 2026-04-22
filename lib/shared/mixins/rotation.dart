import 'dart:math';

import 'package:flame/components.dart';

enum RotationDirection {
  clockwise,
  counterClockwise;

  RotationDirection get inverted => this == RotationDirection.clockwise
      ? RotationDirection.counterClockwise
      : RotationDirection.clockwise;
}

mixin Rotation on PositionComponent {
  // rotation speed
  double rotationSpeed = 0.9;
  // rotation direction
  RotationDirection rotationDirection = RotationDirection.clockwise;

  // rotate the component by updating its angle
  // based on the rotation speed and direction
  void rotate(
    double dt, {
    bool invertDirectionOnLimit = false,
    double angleLimit = 2 * pi,
  }) {
    // calculate the angle change based on the rotation speed and time delta
    final angleDelta = dt * rotationSpeed;
    // update the angle based on the rotation direction
    angle = rotationDirection == RotationDirection.clockwise
        ? (angle + angleDelta) % (2 * pi)
        : (angle - angleDelta) % (2 * pi);

    // if the angle exceeds the limit, invert the rotation direction
    if (invertDirectionOnLimit && (angle < 0 || angle > angleLimit)) {
      rotationDirection = rotationDirection.inverted;
    }
  }
}
