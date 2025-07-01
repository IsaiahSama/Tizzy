import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizzy_watch/core/client.dart';
import 'package:tizzy_watch/core/constants.dart';
import 'package:uuid/uuid.dart';


class AuthService {
  static Future<bool> userRegistered() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? deviceID = await asyncPrefs.getString(deviceIDKey);
    final String? fcmToken = await asyncPrefs.getString(fcmTokenKey);
    return deviceID != null && fcmToken != null;
  }

  static Future<void> registerUser(String gender, BuildContext? context) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final deviceID = Uuid().v1();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings _ = await messaging.requestPermission(provisional: false);

    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken == null) {
      throw Exception("FCM token not available. Try registering user again.");
    }

    final response = await Client.makePostRequest(registerURL, {"device_id": deviceID, "fcm_key": fcmToken}, context);

    if (response != null && response.statusCode != 200) {
      throw Exception("Failed to register user. Status code: ${response.statusCode}");
    }
    await asyncPrefs.setString(deviceIDKey, deviceID);
    await asyncPrefs.setString(fcmTokenKey, fcmToken);
    await asyncPrefs.setString(genderKey, gender);

  }

  static Future<void> setCompanion(String companionID, BuildContext? context) async {

    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? deviceID = await asyncPrefs.getString(deviceIDKey);
    final String? fcmToken = await asyncPrefs.getString(fcmTokenKey);

    final response = await Client.makePostRequest(companionURL,{"device_id": deviceID, "fcm_key": fcmToken, "companion_id": companionID}, context);

    if (response != null && response.statusCode != 200) {
      throw Exception("Failed to set companion. Status code: ${response.statusCode}");
    }
    await asyncPrefs.setString(companionIDKey, companionID);
  }

  static Future<String?> getDeviceID() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? deviceID = await asyncPrefs.getString(deviceIDKey);
    return deviceID;
  }

  static Future<String?> getFCMToken() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? fcmToken = await asyncPrefs.getString(fcmTokenKey);
    return fcmToken;
  }

  static Future<String?> getGender() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? gender = await asyncPrefs.getString(genderKey);
    return gender;
  }

  static Future<void> clearUser(BuildContext? context) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    try{
      await Client.makePostRequest(deleteURL, {"device_id": await asyncPrefs.getString(deviceIDKey), "fcm_key": await asyncPrefs.getString(fcmTokenKey)}, context);
    }
    catch(e){
      print("Error deleting user: $e");
    }

    await asyncPrefs.clear();
  }
}