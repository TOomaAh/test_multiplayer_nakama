import 'package:flame/components.dart';
import 'package:flutter_nakama/nakama.dart';
import 'package:multiplayer/button.dart';
import 'package:multiplayer/square.dart';

class PadComponent extends PositionComponent {
  PadComponent({
    required Vector2 position,
    required Vector2 size,
    required this.square,
    required this.match,
    required this.session,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  Square square;
  final match;
  final session;
  bool isListening = false;
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
  void update(double dt) async {
    listen();
    if (direction == ButtonDirection.up) {
      square.position.y -= 10;
    } else if (direction == ButtonDirection.down) {
      square.position.y += 10;
    } else if (direction == ButtonDirection.left) {
      square.position.x -= 10;
    } else if (direction == ButtonDirection.right) {
      square.position.x += 10;
    }
    super.update(dt);
  }

  void listen() {
    if (isListening) return;
    print("Start listening");
    NakamaWebsocketClient.instance.onMatchData.listen((e) {
      if (session.userId != e.presence.userId) {
        direction = ButtonDirection.values[e.opCode.toInt()];
      }
    });
    isListening = true;
  }

  void changeDirection(ButtonDirection direction) async {
    NakamaWebsocketClient.instance
        .sendMatchData(
          matchId: match.matchId,
          opCode: Int64(direction.index),
          data: direction.name.codeUnits,
        )
        .then((value) => value);
    //this.direction = direction;
  }

  @override
  void onGameResize(Vector2 size) {
    position = Vector2(size.x - 150, size.y - 150);
    super.onGameResize(size);
  }
}
