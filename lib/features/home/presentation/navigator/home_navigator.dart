import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/navigator/login_navigator.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/navigator/batch_student_navigator.dart';

final homeNavigatorProvider = Provider(
  (ref) => HomeNavigator(),
);

class HomeNavigator with BatchStudentRoute, LoginRoute, BatchStudentRoute {
  @override
  late BuildContext context;
}

mixin HomeRoute {
  openHomeScreen() {
    Navigator.popAndPushNamed(context, AppRoute.homeRoute);
  }

  BuildContext get context;
}
