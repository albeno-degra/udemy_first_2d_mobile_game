import 'package:first_2d_mobile_game/utils/color_from_gradient.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

const healthGradient = LinearGradient(
  colors: [Colors.red, Colors.yellow, Colors.green],
  stops: [0.0, 0.5, 1.0],
);

class HealthBar extends PositionComponent {
  /// Public property
  double health = 100;

  /// Maximum
  final double _maxHealth = 100.0;

  /// Paint's properties of empty area of HealthBar
  final Paint _emptySpacePaint = Paint()
    ..color = Colors.grey.withValues(alpha: 0.4);

  /// Paint's properties of strole
  final Paint _barStrokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeWidth = 0.5;

  /// Decrease health
  void decrease(double amount) {
    health = (health - amount).clamp(0, _maxHealth);
  }

  /// Restore the health count
  void restore() => health = 100;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final barHeight = size.y;
    // set the anchor to the bottom left of the health bar
    anchor = Anchor.bottomLeft;

    // Calculate health percentage and corresponding bar dimensions
    final healthPercentage = health / _maxHealth;
    // Calculate the width of the health bar based on the health percentage
    final barWidth = size.x * healthPercentage;

    final healthRect = Rect.fromLTWH(0, 0, barWidth, barHeight - 5);
    final barStrokeRect = Rect.fromLTWH(0, 0, size.x, barHeight - 5);
    final emptySpaceRect = Rect.fromLTWH(
      barWidth,
      0,
      size.x - barWidth,
      barHeight - 5,
    );

    final healthPaint = Paint()
      ..color = colorFromGradient(
        gradient: healthGradient,
        size: Size(width, height),
        point: Offset(barWidth, barHeight / 2),
      );

    // draw the health bar stroke
    canvas.drawRect(barStrokeRect, _barStrokePaint);
    // draw the empty space of the health bar
    canvas.drawRect(emptySpaceRect, _emptySpacePaint);
    // draw the filled portion of the health bar
    canvas.drawRect(healthRect, healthPaint);
  }
}
