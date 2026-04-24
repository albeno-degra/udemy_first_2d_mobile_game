import 'dart:math';

import 'package:first_2d_mobile_game/utils/angles_utils.dart';
import 'package:flame/extensions.dart';

Vector2 getRandomPosition({
  required Rect bounds,
  Vector2? parentPosition,
  Random? randomEntity = null,
}) {
  final random = randomEntity ?? Random();

  final isFromLeftSide = random.nextBool();
  final isFromTop = random.nextBool();
  return Vector2(
    parentPosition != null
        ? parentPosition.x + random.nextInt(40) - 40
        : isFromLeftSide
        ? bounds.left + random.nextDouble() * 10
        : bounds.right - random.nextDouble() * 10,
    parentPosition != null
        ? parentPosition.y + random.nextInt(40) - 40
        : isFromTop
        ? bounds.top + random.nextDouble() * 10
        : bounds.bottom - random.nextDouble() * 10,
  );
}

Vector2 getRandomVelocity({
  required AngleQuadrant quadrant,
  double maxSpeed = 100,
  double minSpeed = 30,
  Random? randomEntity = null,
}) {
  final random = randomEntity ?? Random();
  final speed = minSpeed + random.nextDouble() * (maxSpeed - minSpeed);
  late final double dx;
  late final double dy;
  switch (quadrant) {
    case AngleQuadrant.topLeft:
      dx = random.nextDouble();
      dy = random.nextDouble();
      break;

    case AngleQuadrant.topRight:
      dx = -random.nextDouble();
      dy = random.nextDouble();
      break;

    case AngleQuadrant.bottomLeft:
      dx = random.nextDouble();
      dy = -random.nextDouble();
      break;

    case AngleQuadrant.bottomRight:
      dx = -random.nextDouble();
      dy = -random.nextDouble();
      break;
  }
  return Vector2(dx, dy).normalized() * speed;
}

List<Vector2> getRandomPolygonVertices({
  int? vertexCount,
  double minRadius = 20,
  double maxRadius = 50,
  Random? randomEntity = null,
}) {
  final random = randomEntity ?? Random();
  final vertices = <Vector2>[];
  vertexCount ??= random.nextInt(5) + 5;
  for (int i = 0; i < vertexCount; i++) {
    final angle = (i / vertexCount) * 2 * pi;
    final radius = minRadius + random.nextDouble() * (maxRadius - minRadius);
    vertices.add(Vector2(cos(angle), sin(angle)) * radius);
  }
  return vertices;
}
