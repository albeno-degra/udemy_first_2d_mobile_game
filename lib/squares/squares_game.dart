import 'package:first_2d_mobile_game/squares/square.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

//
//
// The game class
class SquaresGame extends FlameGame with DoubleTapDetector, TapCallbacks {
  bool running = true;

  @override
  //
  //
  // Process user's single tap (tap up)
  void onTapUp(TapUpEvent info) {
    // location of user's tap
    final touchPoint = info.localPosition;

    add(
      Square()
        ..position = touchPoint
        ..squareSize = 45.0
        ..velocity = Vector2(0, 1).normalized() * 50
        ..color = (BasicPalette.red.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2),
    );
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}
