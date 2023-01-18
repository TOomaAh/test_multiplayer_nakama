import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameWidget<MultiplayerGame>(
        game: MultiplayerGame(),
      ),
    ),
  );
}
