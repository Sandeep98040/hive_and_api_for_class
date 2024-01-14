import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/common/provider/is_dark_theme.dart';
import 'package:hive_and_api_for_class/core/common/snackbar/my_snackbar.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:hive_and_api_for_class/features/course/presentation/viewmodel/course_viewmodel.dart';
import 'package:hive_and_api_for_class/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:hive_and_api_for_class/features/home/presentation/widget/batch_widget.dart';

import '../../widget/course_widget.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late bool isDark;
  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var batchState = ref.watch(batchViewModelProvider);
    var courseState = ref.watch(courseViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard View'),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(batchViewModelProvider.notifier).getBatches();
              // ref.read(courseViewModelProvider.notifier).getCourses();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              await ref.read(homeViewModelProvider.notifier).logout();
              if (context.mounted) {
                showSnackBar(
                  message: 'Loggin out...',
                  context: context,
                  color: Colors.red,
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                  ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Batches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: BatchWidget(ref: ref, batchList: batchState.batches),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: CourseWidget(courseList: courseState.courses),
            ),
          ],
        ),
      ),
    );
  }
}
