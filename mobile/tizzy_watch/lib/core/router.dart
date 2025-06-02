import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/core/auth.dart';
import 'package:tizzy_watch/presentation/screens/home_screen.dart';
import 'package:tizzy_watch/presentation/screens/iseeyou_screen.dart';
import 'package:tizzy_watch/presentation/screens/register_screen.dart';
import 'package:tizzy_watch/presentation/screens/tempo_screen.dart';
import 'package:tizzy_watch/presentation/screens/tizzchat_screen.dart';
import 'package:tizzy_watch/presentation/screens/profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) async {
    final bool registered = await AuthService.userRegistered();
    final bool registering = state.matchedLocation == '/register';

    if (!registered) {
      return '/register';
    }

    if (registering) {
      return '/';
    }

    // no need to redirect at all
    return null;
  },
  routes: [
    GoRoute(name: 'Home', path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(name: 'Profile', path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(name: 'Register', path: '/register', builder: (context, state) => RegisterScreen()),
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
  ],
);
