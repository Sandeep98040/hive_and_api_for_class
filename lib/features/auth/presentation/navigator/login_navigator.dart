import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/navigator/register_navigator.dart';
import 'package:hive_and_api_for_class/features/home/presentation/navigator/home_navigator.dart';

import '../../../../config/router/app_route.dart';

final loginNavigatorProvider = Provider((ref) => LoginNaviator());

// Go from login to register
class LoginNaviator with RegisterRoute, HomeRoute {
  @override
  late BuildContext context;
}

mixin LoginRoute {
  openLoginScreen() {
    Navigator.popAndPushNamed(context, AppRoute.loginRoute);
  }

  BuildContext get context;
}
