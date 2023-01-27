import 'package:flutter/material.dart';
import 'package:flutter_nakama/nakama.dart';

class NakamaProvider extends ChangeNotifier {

  final Nakama nakamaInstance;
  late Session session;
  NakamaProvider({required this.nakamaInstance});

  init() async {
    session = await nakamaInstance.authenticate();
  }

  createMatch() async {
    NakamaWebsocketClient.init(
      host: '192.168.1.38',
      ssl: false,
      token: session.token,
    );
    return await NakamaWebsocketClient.instance.createMatch();
  }
  
}


class Nakama {
  final String deviceId;
  Nakama({required this.deviceId});
  final client = getNakamaClient(
    host: '192.168.1.38',
    ssl: false,
    serverKey: 'defaultkey',
  );

  Future<Session> authenticate() async {
    return await client.authenticateDevice(deviceId: deviceId);
  }
}