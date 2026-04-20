//
//
// Simple component shape example of a square component
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Square extends PositionComponent with TapCallbacks {
  //
  // default values
  //

  // velocity is 0 here
  Vector2 velocity = Vector2(0, 0).normalized() * 25;
  // large square
  double squareSize = 128.0;
  // colored white with no-fill and an outline strike
  Paint color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  //
  // initialize the component
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.topRight;
  }

  @override
  //
  // update the inner state of the shape
  // in our case the position based on velocity
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
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
