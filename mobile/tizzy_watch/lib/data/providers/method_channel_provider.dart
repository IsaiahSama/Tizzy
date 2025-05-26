import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart'; 

// final methodChannelProvider = Provider<MethodChannel>((ref) {
//   const methodChannel = MethodChannel('app.channel.process.data');
//   return methodChannel;
// });

const _methodChannel = MethodChannel('app.channel.process.data');

Future<String?> getSharedData() async {
  final sharedData = await _methodChannel.invokeMethod('getSharedText'); // <- Name of the method from Kotlin
  if (sharedData is String) {
    return sharedData;
  }

  return null;
}