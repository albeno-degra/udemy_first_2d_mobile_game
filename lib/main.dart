import 'package:first_2d_mobile_game/asteroids_game.dart';
import 'package:first_2d_mobile_game/mixins/scene_changer.dart';
import 'package:first_2d_mobile_game/widgets/game_over.dart';
import 'package:first_2d_mobile_game/widgets/score.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final asteroidsGame = AsteroidsGame();

  Flame.device.fullScreen();
  Flame.images.prefix = '';

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: asteroidsGame,
          overlayBuilderMap: {
            AsteroidGameOverlay.gameOver.title:
                (BuildContext context, AsteroidsGame game) {
                  return GameOverWidget(
                    onNewGamePressed: game.startNewGame,
                    score: asteroidsGame.player.score.value,
                  );
                },
            AsteroidGameOverlay.score.title:
                (BuildContext context, AsteroidsGame game) {
                  return ScoreWidget(score: asteroidsGame.player.score);
                },
          },
        ),
      ),
    ),
  );
}
