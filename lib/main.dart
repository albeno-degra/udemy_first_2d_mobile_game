import 'package:first_2d_mobile_game/squares/squares_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final asteroidsGame = AsteroidsGame();
  final squaresGame = SquaresGame();
  Flame.device.fullScreen();
  Flame.images.prefix = '';
  runApp(
    GameWidget(game: squaresGame),
  );
}
