import 'package:checklist_app/model/checklist.dart';
import 'package:checklist_app/view/screen/checklist_screen.dart';
import 'package:checklist_app/view/screen/home_screen.dart';
import 'package:checklist_app/view/screen/privacy_policy.dart';
import 'package:checklist_app/view/screen/profile_screen.dart';
import 'package:checklist_app/view/screen/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final router = GoRouter(
    initialLocation: HomeScreen.route,
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: HomeScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: 'profile',
        path: ProfileScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        name: 'checklist',
        path: ChecklistScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          final checklist =
              state.extra == null ? null : state.extra as ChecklistModel;
          return ChecklistScreen(checklist: checklist);
        },
      ),
      GoRoute(
        name: 'privacy',
        path: PrivacyPolicy.route,
        builder: (BuildContext context, GoRouterState state) {
          return const PrivacyPolicy();
        },
      ),
      GoRoute(
        name: 'terms and conditions',
        path: TermsAndConditions.route,
        builder: (BuildContext context, GoRouterState state) {
          return const TermsAndConditions();
        },
      ),
    ],
  );
}
