import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/core/auth.dart';
import 'package:tizzy_watch/presentation/screens/stats_screen.dart';
import 'package:tizzy_watch/presentation/screens/register_screen.dart';
import 'package:tizzy_watch/presentation/screens/tempo_screen.dart';
import 'package:tizzy_watch/presentation/screens/countdown_screen.dart';
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
    GoRoute(
      name: 'Home',
      path: '/',
      builder: (context, state) => TempoScreen(),
    ),
    GoRoute(
      name: 'Profile',
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      name: 'Register',
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      name: 'Countdowns',
      path: '/countdowns',
      builder: (context, state) => CountdownScreen(),
    ),
    GoRoute(
      name: 'Stats',
      path: '/stats',
      builder: (context, state) => StatsScreen(),
    ),
    GoRoute(
      name: 'TizzChat',
      path: '/tizzchat',
      builder: (context, state) => TizzChatScreen(),
    ),
  ],
);
