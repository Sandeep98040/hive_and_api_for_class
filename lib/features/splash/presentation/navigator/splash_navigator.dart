import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';

import '../../../auth/presentation/navigator/login_navigator.dart';
import '../../../home/presentation/navigator/home_navigator.dart';

final splashNavigatorProvider = Provider((ref) => SplashNavigator());

// Go from splash to login
class SplashNavigator with LoginRoute, HomeRoute {
  @override
  late BuildContext context;
}

// mixin : used when we want to use the properties of another class
//without extending it
mixin SplashRoute {
  openSplashScreen() {
    Navigator.pushNamed(context, AppRoute.splashRoute);
  }

  // this context is not initialized here
  // Who ever will call this mixin will have to initialize it
  BuildContext get context;
}
