import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:multiplayer/nakama.dart';
import 'package:multiplayer/pad.dart';
import 'package:multiplayer/square.dart';

class MultiplayerGame extends FlameGame with HasTappableComponents {

  @override
  Future<void> onLoad() async {
    print("MultiplayerGame.onLoad() called");
    Square square = Square(
      position: size / 2,
      size: Vector2(100, 100),
    );
    await addAll([
      square,
      PadComponent(
        square: square,
        position: size * 0.80,
        size: Vector2(150, 150),
      ),
    ]);
    await super.onLoad();
  }
}
