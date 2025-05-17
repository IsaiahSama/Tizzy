import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/presentation/screens/home_screen.dart';
import 'package:tizzy_watch/presentation/screens/iseeyou_screen.dart';
import 'package:tizzy_watch/presentation/screens/tempo_screen.dart';
import 'package:tizzy_watch/presentation/screens/tizzchat_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'Home',
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: 'Tempo',
      path: '/tempo',
      builder: (context, state) => TempoScreen(),
    ),
    GoRoute(
      name: 'ISeeYou',
      path: '/iseeyou',
      builder: (context, state) => ISeeYouScreen(),
    ),
    GoRoute(
      name: 'TizzChat',
      path: '/tizzchat',
      builder: (context, state) => TizzChatScreen(),
    ),
  ]
);