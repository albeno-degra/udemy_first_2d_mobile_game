import 'package:first_2d_mobile_game/asteroids/bullet.dart';
import 'package:first_2d_mobile_game/asteroids/joystick_player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class AsteroidsGame extends FlameGame with TapCallbacks, DragCallbacks {
  //
  // The player being controlled by Joystick
  late final JoystickPlayer player;
  //
  // The actual Joystick component
  late final JoystickComponent joystick;
  //
  // angle of the ship being displayed on canvas
  final TextPaint shipAngleTextPaint = TextPaint();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //
    // joystick knob and background skin styles
    final knobPaint = BasicPalette.green.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.green.withAlpha(100).paint();
    //
    // Actual Joystick component creation
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    //
    // adding the player that will be controlled by our joystick
    player = JoystickPlayer(joystick);

    //
    // add both joystick and the controlled player to the game instance
    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    //
    //  show the angle of the player
    super.update(dt);
  }

  @override
  //
  //
  // We will handle the tap action by the user to shoot a bullet
  // each time the user taps and lifts their finger
  void onTapUp(TapUpEvent info) {
    //
    // velocity vector pointing straight up.
    // Represents 0 radians which is 0 desgrees
    final velocity = Vector2(0, -1);
    // rotate this vector to the same ange as the player
    velocity.rotate(player.angle);
    // create a bullet with the specific angle and add it to the game
    add(Bullet(player.position, velocity));
    super.onTapUp(info);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //
    // render the angle in radians for reference
    shipAngleTextPaint.render(
      canvas,
      '${player.angle.toStringAsFixed(5)} radians',
      Vector2(20, size.y - 24),
    );
  }
}
