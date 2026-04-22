import 'package:first_2d_mobile_game/shared/utils/color_from_gradient.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

const healthGradient = LinearGradient(
  colors: [Colors.red, Colors.yellow, Colors.green],
  stops: [0.0, 0.5, 1.0],
);

class HealthBar extends PositionComponent {
  double health = 100.0;
  double maxHealth = 100.0;
  Color emptySpaceColor = Colors.grey.withValues(alpha: 0.4);
  Color strokeColor = Colors.white;
  double strokeWidth = 0.5;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final barHeight = size.y;
    // set the anchor to the bottom left of the health bar
    anchor = Anchor.bottomLeft;

    // Calculate health percentage and corresponding bar dimensions
    final healthPercentage = health / maxHealth;
    // Calculate the width of the health bar based on the health percentage
    final barWidth = size.x * healthPercentage;

    final healthRect = Rect.fromLTWH(0, 0, barWidth, barHeight - 5);
    final barStrokeRect = Rect.fromLTWH(0, 0, size.x, barHeight - 5);
    final emptySpaceRect =
        Rect.fromLTWH(barWidth, 0, size.x - barWidth, barHeight - 5);

    final healthPaint = Paint()
      ..color = colorFromGradient(
        gradient: healthGradient,
        size: Size(width, height),
        point: Offset(barWidth, barHeight / 2),
      );
    final emptySpacePaint = Paint()..color = emptySpaceColor;
    final baeStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = strokeColor
      ..strokeWidth = strokeWidth;

    // draw the health bar stroke
    canvas.drawRect(
      barStrokeRect,
      baeStrokePaint,
    );
    // draw the empty space of the health bar
    canvas.drawRect(
      emptySpaceRect,
      emptySpacePaint,
    );
    // draw the filled portion of the health bar
    canvas.drawRect(healthRect, healthPaint);
  }
}
