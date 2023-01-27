import 'package:flutter_nakama/nakama.dart';

class Nakama {
  // singleton instance
  static final Nakama _instance = Nakama._internal();
  final client = getNakamaClient(
    host: '192.168.1.38',
    ssl: false,
    serverKey: 'defaultkey',
  );

  // private constructor
  Nakama._internal();

  // public factory
  factory Nakama() {
    return _instance;
  }
}
