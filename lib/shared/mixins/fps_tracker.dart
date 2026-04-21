import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

mixin FpsTracker on FlameGame {
  //
  // FPS counter
  late final FpsComponent fpsCounter;

//
// position of the FPS counter text on the canvas
  Vector2 _fpsCounterPosition = Vector2(20, 30);
//
// setter for the FPS counter position
  set fpsCounterPosition(Vector2 position) {
    _fpsCounterPosition = position;
  }

//
  // FPS text style
  TextStyle _fpsTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
  );
//
// setter for the FPS text style
  set fpsTextStyle(TextStyle style) {
    _fpsTextStyle = style;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //
    // FPS counter component creation
    fpsCounter = FpsComponent(
      windowSize: CameraComponent.maxCamerasDepth,
    );
    add(fpsCounter);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final String fpsText = 'FPS: ${fpsCounter.fps.toStringAsFixed(2)}';
    final fpsTextPaint = TextPaint(
      style: _fpsTextStyle,
    );
    fpsTextPaint.render(canvas, fpsText, _fpsCounterPosition);
  }
}
