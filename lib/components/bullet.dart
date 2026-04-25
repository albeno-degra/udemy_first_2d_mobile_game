import 'package:first_2d_mobile_game/gen/assets.gen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Bullet extends PositionComponent
    with HasGameReference, CollisionCallbacks {
  /// Bullet's paint
  static final _paint = Paint()..color = Colors.white;
  // The bullet speed in pixles per second
  final double _speed = 150;
  // Velocity vector for the bullet.
  late Vector2 _velocity;

  //
  // default constructor with default values
  Bullet(Vector2 position, Vector2 velocity)
    : _velocity = velocity,
      super(
        position: position,
        size: Vector2.all(4), // 2x2 bullet
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // _velocity is a unit vector so we need to make it account for the actual
    // speed.
    _velocity = (_velocity)..scaleTo(_speed);
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    FlameAudio.play(Assets.audio.missileFlyby);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, _paint);
  }

  @override
  void update(double dt) {
    position.add(_velocity * dt);
  }
}
