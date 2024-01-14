import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_and_api_for_class/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/navigator/login_navigator.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
    ref.read(loginNavigatorProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;
  final LoginNaviator loginNavigator;

  AuthViewModel(
    this._authUseCase,
    this.loginNavigator,
  ) : super(AuthState(isLoading: false));

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> registerStudent(AuthEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerStudent(student);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  loginStudent(
    String username,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.loginStudent(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeScreen();
      },
    );
  }

  resetState() {
    state = state.copyWith(isLoading: false, error: null, imageName: null);
  }

  // Go to home screen
  openHomeScreen() {
    loginNavigator.openHomeScreen();
  }

  // Go to regiser screen
  openRegisterScreen() {
    loginNavigator.openRegisterScreen();
  }
}
