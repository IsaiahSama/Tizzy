// This is a service that will allow for communication between the mobile application and the watch application through gadgetbridge intents

import 'package:android_intent_plus/android_intent.dart';
import 'package:tizzy_watch/core/auth.dart';
import 'package:tizzy_watch/domain/tempo_message.dart';
import 'dart:convert';

class GadgetBridgeService {

  static Future<void> sendToBangle(String appFunctionName, Map<String, dynamic> data) async {
    String args = jsonEncode(data);
    AndroidIntent intent = AndroidIntent( 
      action: 'com.banglejs.uart.tx',
      package:
          'com.espruino.gadgetbridge.banglejs',
      // arguments: {'line': "custom({'tempo': '$msg'})"},
      arguments: {'line': "$appFunctionName($args)"},
    );
    await intent.sendBroadcast();
  }

  static Future<void> sendTempoMesssage(TempoMessage msg) async {
    String? userID = await AuthService.getDeviceID();

    if (userID != null) {
      await sendUserID(userID);
    }

    Map<String, dynamic> data = {'message': msg.message};
    await sendToBangle('displayTempo', data);
  }

  static Future<void> sendUserID(String? userID) async {
    if (userID == null){
      userID = await AuthService.getDeviceID();
      if (userID == null) return;
    }
    
    Map<String, dynamic> data = {'userID': userID};
    await sendToBangle('setUserID', data);
  }
}