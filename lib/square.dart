import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Square extends PositionComponent {
  Square({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Future<void> onLoad() async {
    final rectangle = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.red,
    );

    await add(rectangle);
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    super.onGameResize(size);
  }
}
