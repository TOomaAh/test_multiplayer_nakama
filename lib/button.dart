import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum ButtonDirection {
  idle,
  up,
  down,
  left,
  right,
}

class ButtonComponent extends RectangleComponent with TapCallbacks {
  ButtonComponent({
    required Vector2 position,
    required Vector2 size,
    required this.direction,
    required this.directionOnTap,
  }) : super(
          position: position,
          size: size,
          paint: Paint()..color = Colors.blueGrey,
        );

  Function directionOnTap;
  ButtonDirection direction;

  @override
  void onTapUp(TapUpEvent event) {
    directionOnTap(ButtonDirection.idle);
    super.onTapUp(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    directionOnTap(direction);
    super.onTapDown(event);
  }
}
