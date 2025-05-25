// This is a service that will allow for communication between the mobile application and the watch application through gadgetbridge intents

import 'package:android_intent_plus/android_intent.dart';
import 'package:tizzy_watch/domain/entities/tempo_message.dart';

class GadgetBridgeService {

  static Future<void> sendToBangle(String appFunctionName, Map<String, dynamic> data) async {
    AndroidIntent intent = AndroidIntent( 
      action: 'com.banglejs.uart.tx',
      package:
          'com.espruino.gadgetbridge.banglejs',
      arguments: {'line': "$appFunctionName(${data.toString()})"},
    );
    await intent.sendBroadcast();
  }

  static Future<void> sendTempoMesssage(TempoMessage msg) async {
    Map<String, dynamic> data = {'message': msg.content, 'color': msg.color};
    await sendToBangle('displayTempo', data);
  }
}