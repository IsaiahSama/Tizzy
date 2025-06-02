import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serverURL = "https://tizzy.onrender.com";

final dioProvider = Provider<Dio>((ref) => Dio(
  BaseOptions(
    baseUrl: serverURL,
  ),
));