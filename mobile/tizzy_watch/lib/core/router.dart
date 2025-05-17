import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'Home',
      path: '/',
      builder: (context, state) => Container(),
    ),
    GoRoute(
      name: 'Tempo',
      path: '/tempo',
      builder: (context, state) => Container(),
    ),
    GoRoute(
      name: 'ISeeYou',
      path: '/iseeyou',
      builder: (context, state) => Container(),
    ),
    GoRoute(
      name: 'TizzChat',
      path: '/tizzchat',
      builder: (context, state) => Container(),
    ),
  ]
);