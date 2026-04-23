import 'dart:math';

import 'package:first_2d_mobile_game/shared/mixins/fps_tracker.dart';
import 'package:first_2d_mobile_game/shared/utils/random.dart';
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

  //
  // bounds of the game world, used for random position generation
  late final Rect bounds;

  late final List<Rect> boundsOuterSpaces = [
    // top
    Rect.fromLTWH(0, 0, size.x, padding),
    // bottom
    Rect.fromLTWH(0, size.y - padding, size.x, padding),
    // left
    Rect.fromLTWH(0, 0, padding, size.y),
    // right
    Rect.fromLTWH(size.x - padding, 0, padding, size.y),
  ];

  final squareSize = const Size.square(45.0);

  // outer space padding around the game world
  static const padding = 20.0;

  // random generator instance for the game
  final Random random = Random();

  ///
  /// text rendering const
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 14.0,
      fontFamily: 'Awesome Font',
    ),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    bounds = Rect.fromLTWH(
      padding,
      padding,
      size.x - padding * 2,
      size.y - padding * 2,
    );
  }

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

    // render the outer spaces of the game world with a dark gray color
    renderOuterSpaces(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (final child in children) {
      if (child is Square) {
        final deflate = child.velocity.angleTo(Vector2.zero()) > pi / 2
            ? squareSize.width / 2
            : -squareSize.width / 2;
        // if the square goes out of bounds, remove it from the game
        if (!(bounds.deflate(deflate)).contains(child.position.toOffset())) {
          child.removeFromParent();
        }
      }
    }
  }

  void renderOuterSpaces(Canvas canvas) {
    for (final rect in boundsOuterSpaces) {
      canvas.drawRect(
        rect,
        BasicPalette.darkGray.paint()..style = PaintingStyle.fill,
      );
    }
  }

  @override
  // process user's single tap (tap up)
  void onTapUp(TapUpEvent info) {
    add(
      Square()
        ..position = getRandomPosition(bounds: bounds, randomEntity: random)
        ..squareSize = squareSize
        ..velocity = getRandomVelocity(randomEntity: random)
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
