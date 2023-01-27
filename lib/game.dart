import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter_nakama/nakama.dart';
import 'package:multiplayer/nakama_provider.dart';
import 'package:multiplayer/pad.dart';
import 'package:multiplayer/square.dart';
import 'package:provider/provider.dart';

class MultiplayerGame extends FlameGame with HasTappableComponents {
  final context;

  MultiplayerGame({required this.context});

  @override
  Future<void> onLoad() async {
    await Provider.of<NakamaProvider>(context, listen: false).init();
    Provider.of<NakamaProvider>(context, listen: false).initWebSocket();

    /*var match =
        await Provider.of<NakamaProvider>(context, listen: false).createMatch();
    NakamaWebsocketClient.instance.sendMatchData(
      matchId: match.matchId,
      opCode: Int64(0),
      data: 'hello world'.codeUnits,
    );

    print("matchid: ${match.matchId}");*/

    final match = await NakamaWebsocketClient.instance
        .joinMatch("814a4613-7d8f-43ad-a8fc-49580671b6bd.");
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
        match: match,
        session: Provider.of<NakamaProvider>(context, listen: false).session,
      ),
    ]);
    await super.onLoad();
  }
}
