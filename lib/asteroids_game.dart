import 'package:first_2d_mobile_game/components/asteroid.dart';
import 'package:first_2d_mobile_game/components/bullet.dart';
import 'package:first_2d_mobile_game/components/ship_player.dart';
import 'package:first_2d_mobile_game/gen/assets.gen.dart';
import 'package:first_2d_mobile_game/mixins/scene_changer.dart';
import 'package:first_2d_mobile_game/utils/random.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AsteroidsGame extends FlameGame
    with
        LongPressDetector,
        TapCallbacks,
        DragCallbacks,
        HasCollisionDetection,
        SceneChanger {
  /// Public cosmic ship (player)
  final ShipPlayer player = ShipPlayer();

  // Public bounds of the game world, used for random position generation
  late final Rect bounds = Rect.fromLTWH(0, 0, size.x, size.y);

  // Game's timers
  late final Timer _asteroidTimer;
  Timer? _bulletTimer;
  Timer? _playerMoveTimer;

  // Action's properties
  Vector2 _bulletVelocity = Vector2.zero();
  Vector2 _tapPosition = Vector2.zero();

  // Is the game over
  bool isGameOver = false;

  // Large asteroid properties
  final _params = AsteroidSize.large.params;

  // Public method creates a new game
  void startNewGame() {
    player.restore();
    isGameOver = false;
    toRunningScene();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(ScreenHitbox());
    toRunningScene();
    add(player);

    _asteroidTimer = Timer(2, onTick: _addRandomAsteroid, repeat: true)
      ..start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update timers by `dt`
    _asteroidTimer.update(dt);
    _bulletTimer?.update(dt);
    _playerMoveTimer?.update(dt);
    // If player is not alive - [GAME OVER]
    if (!isGameOver && !player.isAlive) {
      isGameOver = true;
      toGameOverScene();
      _bulletTimer?.stop();
      _playerMoveTimer?.stop();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    _bulletTimer?.stop();
    _bulletTimer = null;

    // Set player's angle
    _tapPosition = event.localPosition;
    final angle = (_tapPosition - player.position).screenAngle();
    player.angle = angle;

    // Change Bullet's velocity
    final velocity = Vector2(0, -1);
    velocity.rotate(player.angle);

    // Add Bullet
    _addBullet(velocity);
    super.onTapDown(event);
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    _tapPosition = info.eventPosition.global;
    // Start moving
    _playerMoveTimer ??= Timer(
      0.05,
      onTick: () {
        player.move(_tapPosition - player.position);
      },
      repeat: true,
    )..start();

    // Start shooting
    _bulletVelocity = Vector2(0, -1)..rotate(player.angle);
    _bulletTimer ??= Timer(
      0.2,
      onTick: () {
        _addBullet(_bulletVelocity);
      },
      repeat: true,
    )..start();

    super.onLongPressStart(info);
  }

  @override
  void onLongPressMoveUpdate(LongPressMoveUpdateInfo info) {
    _tapPosition = info.eventPosition.global;
    // Change player's angle
    final angle = (_tapPosition - player.position).screenAngle();
    player.angle = angle;

    // Change bullet's velocity
    _bulletVelocity = Vector2(0, -1)..rotate(player.angle);

    super.onLongPressMoveUpdate(info);
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    _bulletTimer?.stop();
    _bulletTimer = null;
    _playerMoveTimer?.stop();
    _playerMoveTimer = null;
    super.onLongPressEnd(info);
  }

  void _addBullet(Vector2 velocity) {
    FlameAudio.play(Assets.audio.laser);
    add(Bullet(player.position, velocity));
  }

  void _addRandomAsteroid() => add(
    Asteroid(
      vertices: getRandomPolygonVertices(
        vertexCount: _params.vertexCount,
        minRadius: _params.minRadius,
        maxRadius: _params.maxRadius,
      ),
    ),
  );
}
