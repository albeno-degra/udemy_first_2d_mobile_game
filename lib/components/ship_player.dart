import 'dart:math';

import 'package:first_2d_mobile_game/components/asteroid.dart';
import 'package:first_2d_mobile_game/components/health_bar.dart';
import 'package:first_2d_mobile_game/gen/assets.gen.dart';
import 'package:first_2d_mobile_game/utils/angles_utils.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShipPlayer extends SpriteComponent
    with HasGameReference, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 300.0;

  /// Player's health bar
  final HealthBar _healthBar = HealthBar();

  /// Public property - is player alive
  bool get isAlive => _healthBar.health > 0;

  /// Score's counter
  final ValueNotifier<int> _score = ValueNotifier(0);

  /// Public listenable for score's count
  ValueListenable<int> get score => _score;

  /// Health bar size is slightly smaller than the square size
  Size get _healthbarSize => Size(size.x, 10);

  ShipPlayer() : super(size: Vector2.all(50.0)) {
    anchor = Anchor.center;
  }

  /// Add player's score
  void addScore(int score) {
    _score.value += score;
  }

  /// Clear player's score
  void restore() {
    _score.value = 0;
    _healthBar.restore();
  }

  /// Move player's ship
  void move(Vector2 delta) {
    position += delta.normalized() * 3;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Set properties of SpriteComponent and PositionComponent
    sprite = await game.loadSprite(Assets.images.asteroidsShip.path);
    position = game.size / 2;
    // Add the health bar as a child of the square
    add(
      _healthBar
        ..size.setValues(_healthbarSize.width, _healthbarSize.height)
        ..position.setValues(0, 0),
    );
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Asteroid && other.isVisible) {
      _healthBar.decrease(5);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (getAngleQuadrant(angle)) {
      case AngleQuadrant.topRight:
        _healthBar.position.setValues(0, size.y * sin(angle));
        break;
      case AngleQuadrant.topLeft:
        _healthBar.position.setValues(-size.x * sin(angle), 0);
        break;
      case AngleQuadrant.bottomLeft:
        _healthBar.position.setValues(size.x, -size.y * cos(angle));
        break;
      case AngleQuadrant.bottomRight:
        _healthBar.position.setValues(
          -size.x * cos(angle),
          size.y + _healthBar.size.y,
        );
        break;
    }
    _healthBar.angle = -angle;
  }
}
