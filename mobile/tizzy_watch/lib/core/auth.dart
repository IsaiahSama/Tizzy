import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizzy_watch/core/constants.dart';
import 'package:tizzy_watch/core/toaster.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';


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

    await asyncPrefs.setString(deviceIDKey, deviceID);
    await asyncPrefs.setString(fcmTokenKey, fcmToken);
    await asyncPrefs.setString(genderKey, gender);

    final formData = FormData.fromMap({"device_id": deviceID, "fcm_key": fcmToken});

    await Dio().post("$serverURL/register", data: formData);
  }

  static Future<void> setCompanion(String companionID, BuildContext? context) async {

    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? deviceID = await asyncPrefs.getString(deviceIDKey);
    final String? fcmToken = await asyncPrefs.getString(fcmTokenKey);

    final formData = FormData.fromMap({"device_id": deviceID, "fcm_key": fcmToken, "companion_id": companionID});
    Toaster.showToast("Setting companion...");
    final response = await Dio().post("$serverURL/companion", data: formData);
    if (response.statusCode != 200) {
      throw Exception("Failed to set companion. Status code: ${response.statusCode}");
    }
    Toaster.showToast("Companion set successfully.");
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

  static Future<void> clearUser() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    final formData = FormData.fromMap({"device_id": await asyncPrefs.getString(deviceIDKey), "fcm_key": await asyncPrefs.getString(fcmTokenKey)});

    try{
      await Dio().post("$serverURL/delete", data: formData);
    }
    catch(e){
      print("Error deleting user: $e");
    }

    await asyncPrefs.clear();
  }
}