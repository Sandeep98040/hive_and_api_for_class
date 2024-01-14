import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';

final registerNavigatorProvider = Provider((ref) => RegisterNavigator());

class RegisterNavigator {}

mixin RegisterRoute {
  openRegisterScreen() {
    Navigator.pushNamed(context, AppRoute.registerRoute);
  }

  BuildContext get context;
}
