import 'package:flame/game.dart';

enum AsteroidGameOverlay {
  gameOver('game_over'),
  score('score');

  final String title;
  const AsteroidGameOverlay(this.title);
}

mixin SceneChanger on FlameGame {
  void toRunningScene() {
    overlays.remove(AsteroidGameOverlay.gameOver.title);
    overlays.add(AsteroidGameOverlay.score.title);
  }

  void toGameOverScene() {
    overlays.add(AsteroidGameOverlay.gameOver.title);
    overlays.remove(AsteroidGameOverlay.score.title);
  }
}
