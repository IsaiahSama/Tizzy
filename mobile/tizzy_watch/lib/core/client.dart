import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/constants.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: serverURL)),
);

final dio = Dio(BaseOptions(baseUrl: serverURL));

class Client {
  static Dio getDio(WidgetRef ref) {
    return ref.watch(dioProvider);
  }

  static Future<void> promptServer() async {
    await dio.get('/');
  }

  static Future<Response?> makePostRequest(
    String url,
    Map<String, dynamic> data,
    BuildContext? context,
  ) async {
    FormData body = FormData.fromMap(data);
    Response<dynamic>? response;
    try {
      response = await dio.post(url, data: body);
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to make request!')));
      }
    }


    String? reason = response?.data?['message'].toString();

    if (context != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(reason ?? 'Sent Successfully!')));
    }

    return response;
  }
}
