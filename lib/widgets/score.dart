import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key, required this.score});

  final ValueListenable score;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      right: 32,
      child: ValueListenableBuilder(
        valueListenable: score,
        builder: (context, value, child) {
          return Text(
            value.toString(),
            style: const TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
