import 'dart:ui' show Rect;

import 'package:first_2d_mobile_game/shared/utils/random.dart';
import 'package:test/test.dart';

void main() {
  group('getRandomVector() tests: ', () {
    test('returns a vector within the specified bounds', () {
      const bounds = Rect.fromLTWH(0, 0, 100, 100);
      final vector = getRandomPosition(bounds: bounds);

      expect(vector.x, inInclusiveRange(bounds.left, bounds.right));
      expect(vector.y, inInclusiveRange(bounds.top, bounds.bottom));
    });
  });

  group('getRandomVelocity() tests: ', () {
    test(
        'returns a velocity vector with a magnitude less than or equal to maxSpeed',
        () {
      const maxSpeed = 10.0;
      final velocity = getRandomVelocity(maxSpeed: maxSpeed);

      expect(velocity.length, lessThanOrEqualTo(maxSpeed));
    });

    test('returns a velocity vector with a magnitude of 0 when maxSpeed is 0',
        () {
      const maxSpeed = 0.0;
      final velocity = getRandomVelocity(maxSpeed: maxSpeed);

      expect(velocity.length, equals(0));
    });
  });
}
