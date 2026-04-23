import 'dart:math';

import 'package:flame/extensions.dart';

Vector2 getRandomPosition({required Rect bounds, Random? randomEntity = null}) {
  final random = randomEntity ?? Random();
  return Vector2(
    bounds.left + random.nextDouble() * bounds.width,
    bounds.top + random.nextDouble() * bounds.height,
  );
}

Vector2 getRandomVelocity({
  double maxSpeed = 100,
  double minSpeed = 30,
  Random? randomEntity = null,
}) {
  final random = randomEntity ?? Random();
  final speed = minSpeed + random.nextDouble() * (maxSpeed - minSpeed);
  return Vector2(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1)
          .normalized() *
      speed;
}
