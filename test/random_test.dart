import 'dart:math';

import 'package:first_2d_mobile_game/utils/angles_utils.dart';
import 'package:first_2d_mobile_game/utils/random.dart';
import 'package:flame/extensions.dart';
import 'package:test/test.dart';

void main() {
  group('getRandomPosition() tests: ', () {
    const bounds = Rect.fromLTWH(0, 0, 300, 600);

    test('spawns near left or right edge when parentPosition is null', () {
      final random = Random(1);

      final pos = getRandomPosition(bounds: bounds, randomEntity: random);

      final isNearLeft = pos.x >= bounds.left && pos.x <= bounds.left + 10;
      final isNearRight = pos.x <= bounds.right && pos.x >= bounds.right - 10;

      expect(isNearLeft || isNearRight, isTrue);

      final isNearTop = pos.y >= bounds.top && pos.y <= bounds.top + 10;
      final isNearBottom =
          pos.y <= bounds.bottom && pos.y >= bounds.bottom - 10;

      expect(isNearTop || isNearBottom, isTrue);
    });

    test('spawns relative to parentPosition when provided', () {
      final random = Random(2);
      final parent = Vector2(150, 200);

      final pos = getRandomPosition(
        bounds: bounds,
        parentPosition: parent,
        randomEntity: random,
      );

      expect(pos.x, inInclusiveRange(parent.x - 40, parent.x));
      expect(pos.y, inInclusiveRange(parent.y - 40, parent.y));
    });
  });

  group('getRandomVelocity() tests: ', () {
    const minSpeed = 30.0;
    const maxSpeed = 100.0;

    Vector2 velocityFor(AngleQuadrant q) =>
        getRandomVelocity(quadrant: q, randomEntity: Random(3));

    test('topLeft velocity points right & down', () {
      final v = velocityFor(AngleQuadrant.topLeft);
      expect(v.x, greaterThan(0));
      expect(v.y, greaterThan(0));
      expect(v.length, inInclusiveRange(minSpeed, maxSpeed));
    });

    test('topRight velocity points left & down', () {
      final v = velocityFor(AngleQuadrant.topRight);
      expect(v.x, lessThan(0));
      expect(v.y, greaterThan(0));
      expect(v.length, inInclusiveRange(minSpeed, maxSpeed));
    });

    test('bottomLeft velocity points right & up', () {
      final v = velocityFor(AngleQuadrant.bottomLeft);
      expect(v.x, greaterThan(0));
      expect(v.y, lessThan(0));
      expect(v.length, inInclusiveRange(minSpeed, maxSpeed));
    });

    test('bottomRight velocity points left & up', () {
      final v = velocityFor(AngleQuadrant.bottomRight);
      expect(v.x, lessThan(0));
      expect(v.y, lessThan(0));
      expect(v.length, inInclusiveRange(minSpeed, maxSpeed));
    });
  });

  group('getRandomPolygonVertices() tests: ', () {
    test('returns correct vertex count', () {
      final vertices = getRandomPolygonVertices(
        vertexCount: 7,
        randomEntity: Random(4),
      );

      expect(vertices.length, 7);
    });

    test('all vertices are within radius bounds', () {
      const minR = 20.0;
      const maxR = 50.0;

      final vertices = getRandomPolygonVertices(
        vertexCount: 10,
        randomEntity: Random(5),
      );

      for (final v in vertices) {
        expect(v.length, inInclusiveRange(minR, maxR));
      }
    });

    test('vertices are distributed around circle', () {
      final vertices = getRandomPolygonVertices(
        vertexCount: 8,
        randomEntity: Random(6),
      );

      final angles = vertices.map((v) => v.angleToSigned(Vector2(1, 0)));
      expect(angles.toSet().length, 8);
    });
  });
}
