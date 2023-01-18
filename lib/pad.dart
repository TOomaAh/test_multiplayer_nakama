import 'package:flame/components.dart';
import 'package:multiplayer/button.dart';
import 'package:multiplayer/square.dart';

class PadComponent extends PositionComponent {
  PadComponent({
    required Vector2 position,
    required Vector2 size,
    required this.square,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  Square square;
  ButtonDirection direction = ButtonDirection.idle;

  @override
  Future<void> onLoad() async {
    await addAll([
      ButtonComponent(
          position: Vector2(50, 0),
          size: Vector2(50, 50),
          direction: ButtonDirection.up,
          directionOnTap: changeDirection),
      ButtonComponent(
          position: Vector2(0, 50),
          size: Vector2(50, 50),
          direction: ButtonDirection.left,
          directionOnTap: changeDirection),
      ButtonComponent(
          position: Vector2(100, 50),
          size: Vector2(50, 50),
          direction: ButtonDirection.right,
          directionOnTap: changeDirection),
      ButtonComponent(
          position: Vector2(50, 100),
          size: Vector2(50, 50),
          direction: ButtonDirection.down,
          directionOnTap: changeDirection),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (direction == ButtonDirection.up) {
      square.position.y -= 100 * dt;
    } else if (direction == ButtonDirection.down) {
      square.position.y += 100 * dt;
    } else if (direction == ButtonDirection.left) {
      square.position.x -= 100 * dt;
    } else if (direction == ButtonDirection.right) {
      square.position.x += 100 * dt;
    }
    super.update(dt);
  }

  void changeDirection(ButtonDirection direction) {
    this.direction = direction;
  }

  @override
  void onGameResize(Vector2 size) {
    position = Vector2(size.x - 150, size.y - 150);
    super.onGameResize(size);
  }
}
