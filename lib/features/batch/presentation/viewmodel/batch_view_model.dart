import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';
import 'package:hive_and_api_for_class/core/common/snackbar/my_snackbar.dart';
import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';
import 'package:hive_and_api_for_class/features/batch/domain/use_case/batch_use_case.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/state/batch_state.dart';

final batchViewModelProvider =
    StateNotifierProvider<BatchViewModel, BatchState>(
  (ref) {
    return BatchViewModel(ref.read(batchUsecaseProvider));
  },
);

class BatchViewModel extends StateNotifier<BatchState> {
  final BatchUseCase batchUseCase;

  BatchViewModel(this.batchUseCase) : super(BatchState.initial()) {
    getAllBatches();
  }

  addBatch(BatchEntity batch) async {
    state.copyWith(isLoading: true);
    var data = await batchUseCase.addBatch(batch);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> deleteBatch(BuildContext context, BatchEntity batch) async {
    state.copyWith(isLoading: true);
    var data = await batchUseCase.deleteBatch(batch.batchId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.batches.remove(batch);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Batch delete successfully',
          context: context,
        );
      },
    );
  }

    getAllBatches() async {
      state = state.copyWith(isLoading: true);
      var data = await batchUseCase.getAllBatches();

      data.fold(
        (l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) =>
            state = state.copyWith(isLoading: false, batches: r, error: null),
      );
    }

    getStudentsByBatch(BuildContext context, String batchId) async {
      state = state.copyWith(isLoading: true);
      var data = await batchUseCase.getAllStudentsByBatch(batchId);

      data.fold(
        (l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
          state = state.copyWith(isLoading: false, students: r, error: null);
          Navigator.pushNamed(context, AppRoute.batchStudentRoute);
        },
      );
    }
  }
