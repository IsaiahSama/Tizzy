import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:tizzy_watch/domain/tempo_message.dart";

part 'messages_provider.g.dart';

@Riverpod(keepAlive: true)
class Messages extends _$Messages {
  @override
  List<TempoMessage> build() {
    return [];
  }

  void addMessage(TempoMessage message) {
    state = [...state, message];
  }

  void clearMessages() {
    state = [];
  }
}