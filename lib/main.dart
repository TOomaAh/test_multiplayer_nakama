import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'game.dart';

void main() async {
  String deviceId;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = (await deviceInfo.iosInfo).identifierForVendor!;
    } else {
      throw Exception('Unsupported platform');
    }
  } catch (e) {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('uuid') == null) {
      // generate uuid
      Uuid uuid = Uuid();
      deviceId = uuid.v4();
      //save uuid to local storage
      await prefs.setString('uuid', deviceId);
    }
    deviceId = prefs.getString('uuid')!;
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameWidget<MultiplayerGame>(
        game: MultiplayerGame(deviceId: deviceId),
      ),
    ),
  );
}
