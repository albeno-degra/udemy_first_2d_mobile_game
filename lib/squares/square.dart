import 'package:first_2d_mobile_game/shared/mixins/rotation.dart';
import 'package:first_2d_mobile_game/squares/health_bar.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

//
//
// Simple component shape example of a square component
class Square extends PositionComponent with TapCallbacks, Rotation {
  final HealthBar healthBar = HealthBar();

  /// velocity is 0 here
  Vector2 velocity = Vector2(0, 0).normalized() * 25;

  /// large square
  Size squareSize = const Size.square(128.0);

  /// health bar size is slightly smaller than the square size
  Size get healthbarSize => Size(squareSize.width - 10, 10);

  /// colored white with no-fill and an outline strike
  Paint color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  //
  // initialize the component
  Future<void> onLoad() async {
    super.onLoad();
    // set the size and anchor of the square
    size.setValues(squareSize.width, squareSize.height);
    // set the anchor to the center of the square
    anchor = Anchor.center;

    // add the health bar as a child of the square
    add(
      healthBar
        ..size.setValues(healthbarSize.width, healthbarSize.height)
        ..position.setValues(0, 0),
    );
  }

  @override
  //
  // update the inner state of the shape
  // in our case the position based on velocity
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
    rotate(dt, invertDirectionOnLimit: true);
    healthBar.health -= 10 * dt;
    if (healthBar.health <= 0) {
      removeFromParent();
    }
  }

  @override
  //
  // render the shape
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    velocity.negate();
  }
}
