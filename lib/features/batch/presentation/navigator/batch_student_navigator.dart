import 'package:flutter/widgets.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';

class BatchStudentNavigator {}

mixin BatchStudentRoute {
  openBatchStudentScreen(String batchId) {
    Navigator.pushNamed(context, AppRoute.batchStudentRoute,
        arguments: 'batchId');
  }

  BuildContext get context;
}
