import 'package:first_2d_mobile_game/asteroids_game.dart';
import 'package:first_2d_mobile_game/components/bullet.dart';
import 'package:first_2d_mobile_game/components/ship_player.dart';
import 'package:first_2d_mobile_game/mixins/rotation.dart';
import 'package:first_2d_mobile_game/utils/angles_utils.dart';
import 'package:first_2d_mobile_game/utils/random.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class AsteroidParams {
  final double minRadius;
  final double maxRadius;
  final int vertexCount;
  const AsteroidParams({
    required this.minRadius,
    required this.maxRadius,
    required this.vertexCount,
  });
}

enum AsteroidSize {
  large,
  medium,
  small;

  AsteroidParams get params {
    switch (this) {
      case AsteroidSize.large:
        return const AsteroidParams(
          minRadius: 25,
          maxRadius: 60,
          vertexCount: 10,
        );
      case AsteroidSize.medium:
        return const AsteroidParams(
          minRadius: 15,
          maxRadius: 40,
          vertexCount: 12,
        );
      case AsteroidSize.small:
        return const AsteroidParams(
          minRadius: 5,
          maxRadius: 15,
          vertexCount: 8,
        );
    }
  }
}

class Asteroid extends PolygonComponent with Rotation, CollisionCallbacks {
  Asteroid({
    required List<Vector2> vertices,
    AsteroidSize? asteroidSize,
    Vector2? parentPosition,
    int? initialAlpha,
  }) : _alpha = initialAlpha ?? 0,
       _parentPosition = parentPosition,
       _initialAlpha = initialAlpha ?? 0,
       _asteroidSize = asteroidSize ?? AsteroidSize.large,
       super(vertices) {}

  /// Asteroid's _velocity
  late Vector2 _velocity;

  /// Cracked asteroid position
  final Vector2? _parentPosition;

  /// Initial asteroid's visibility in alpha channel
  final int _initialAlpha;

  /// Type of asteroid's size
  final AsteroidSize _asteroidSize;

  /// Current Asteroid's alpha
  int _alpha;

  /// Public property
  bool get isVisible => _alpha == 255;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Set anchor, position, _velocity and paint
    anchor = Anchor.center;
    final bounds = (parent as AsteroidsGame).bounds;
    position = getRandomPosition(
      bounds: bounds,
      parentPosition: _parentPosition,
    );
    _velocity = getRandomVelocity(
      quadrant: getPositionQuadrant(position, bounds.center),
    );
    paint = _getPaintFromAlpha(_initialAlpha);

    // Add active HitBox
    add(PolygonHitbox(vertices)..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    super.update(dt);
    rotate(dt);
    position += _velocity * dt;
    _alpha = (_alpha + 1).clamp(0, 255);
    paint = _getPaintFromAlpha(_alpha);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // Asteroid is far away from player
    if (_alpha != 255) {
      return;
    }
    // Get player entity
    final shipPlayer = parent?.children.whereType<ShipPlayer>().first;

    if (other is Bullet) {
      // Remove bullet
      other.removeFromParent();
      switch (_asteroidSize) {
        case AsteroidSize.small:
          shipPlayer?.addScore(50);
          removeFromParent();
          break;
        case AsteroidSize.medium:
          shipPlayer?.addScore(25);
          parent?.addAll(
            _generateRandomAsteroids(count: 3, size: AsteroidSize.small),
          );
          removeFromParent();
          break;
        case AsteroidSize.large:
          shipPlayer?.addScore(10);
          parent?.addAll(
            _generateRandomAsteroids(count: 2, size: AsteroidSize.medium),
          );
          removeFromParent();
          break;
      }
    }
  }

  Paint _getPaintFromAlpha(int alpha) => Paint()
    ..color = Colors.grey.withAlpha(alpha)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  List<Asteroid> _generateRandomAsteroids({
    required int count,
    required AsteroidSize size,
  }) {
    final params = size.params;
    return List.generate(count, (_) {
      return Asteroid(
        vertices: getRandomPolygonVertices(
          minRadius: params.minRadius,
          maxRadius: params.maxRadius,
          vertexCount: params.vertexCount,
        ),
        parentPosition: position,
        initialAlpha: 255,
        asteroidSize: size,
      );
    });
  }
}
