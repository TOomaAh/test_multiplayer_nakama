import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_nakama/api.dart';
import 'package:flutter_nakama/nakama.dart';

class Nakama {
  final deviceId;
  // singleton instance
  static late final Nakama _instance = Nakama._internal(deviceId: deviceId);
  final client = getNakamaClient(
    host: '192.168.1.38',
    ssl: false,
    serverKey: 'defaultkey',
  );

  getSession() async {
    return await client.authenticateDevice(deviceId: deviceId);
  }

  createMatch() async {
    NakamaWebsocketClient.init(
      host: '192.168.1.38',
      ssl: false,
      token: getSession(),
    );

    return await NakamaWebsocketClient.instance.createMatch();
  }

  // private constructor
  Nakama._internal({required this.deviceId});

  void setDeviceId(String deviceId) {
    _instance.deviceId = deviceId;
  }

  // public factory
  factory Nakama() {
    if (_instance._deviceId == null) {
      throw Exception('Device ID not set');
    }
    return _instance;
  }
}
