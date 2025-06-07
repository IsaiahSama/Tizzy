import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/constants.dart';

final dioProvider = Provider<Dio>((ref) => Dio(
  BaseOptions(
    baseUrl: serverURL,
  ),
));

final dio = Dio(
  BaseOptions(
    baseUrl: serverURL,
  ),
);

class Client{
  static Dio getDio(WidgetRef ref){
    return ref.watch(dioProvider);
  }

  static Future<void> makePostRequest(String url, Map<String, dynamic> data) async {
    try {
      await dio.post(url, data: data);
    } catch (e) {
      // do something
    }
  }
}