import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/game.dart';
import 'package:multiplayer/nakama_provider.dart';
import 'package:provider/provider.dart';

class InitGame extends StatefulWidget {
  const InitGame({super.key});

  @override
  State<InitGame> createState() => _InitGameState();
}

class _InitGameState extends State<InitGame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MultiplayerGame multiplayerGame = MultiplayerGame(context: context);
    return GameWidget<MultiplayerGame>(
      game: multiplayerGame,
    );
  }
}
