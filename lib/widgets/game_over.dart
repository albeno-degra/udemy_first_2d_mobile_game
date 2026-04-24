import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    super.key,
    required this.onNewGamePressed,
    required this.score,
  });
  final VoidCallback? onNewGamePressed;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Card(
            color: Colors.white.withValues(alpha: 0.7),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Game over',
                style: TextStyle(color: Colors.black, fontSize: 48),
              ),
            ),
          ),
          Card(
            color: Colors.white.withValues(alpha: 0.7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,

                  overlayColor: Colors.transparent,
                ),
                child: const Text(
                  'Start a new game',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                onPressed: onNewGamePressed,
              ),
            ),
          ),
          Card(
            color: Colors.white.withValues(alpha: 0.7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your score: $score',
                style: const TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
