import 'package:first_2d_mobile_game/shared/mixins/fps_tracker.dart';
import 'package:first_2d_mobile_game/squares/square.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

//
//
// The game class
class SquaresGame extends FlameGame
    with DoubleTapDetector, TapCallbacks, FpsTracker {
  ///
  /// controls of engine running state
  bool running = true;

  ///
  /// if debug mode is on, the game will render additional information such as fps and component boundaries
  @override
  bool debugMode = false;

  ///
  /// text rendering const
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 14.0,
      fontFamily: 'Awesome Font',
    ),
  );

  @override
  void render(Canvas canvas) {
    // first 4 children are: FPSComponent,
    // MultiTapDispatcher, CameraComponent, World;
    textPaint.render(
      canvas,
      'objects active: ${children.length}',
      Vector2(20, 60),
    );
    super.render(canvas);
  }

  @override

  /// process user's single tap (tap up)
  void onTapUp(TapUpEvent info) {
    // location of user's tap
    final touchPoint = info.localPosition;

    add(
      Square()
        ..position = touchPoint
        ..squareSize = const Size.square(45.0)
        ..velocity = Vector2(0, 1).normalized() * 50
        ..color = (BasicPalette.red.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2),
    );
  }

  @override

  /// process user's double tap
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}
