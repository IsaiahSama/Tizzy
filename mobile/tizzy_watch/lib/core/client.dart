import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serverURL = "http://172.20.6.49:8000";

final dioProvider = Provider<Dio>((ref) => Dio(
  BaseOptions(
    baseUrl: serverURL,
  ),
));