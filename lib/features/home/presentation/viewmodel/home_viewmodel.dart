import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/shared_prefs/user_shared_prefs.dart';
import 'package:hive_and_api_for_class/features/home/presentation/navigator/home_navigator.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(
    ref.read(userSharedPrefsProvider),
    ref.read(homeNavigatorProvider),
  ),
);

class HomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  final HomeNavigator homeNavigator;

  HomeViewModel(
    this._userSharedPrefs,
    this.homeNavigator,
  ) : super(false);

  Future<void> logout() async {
    state = true;
    // showSnackBar(
    //     message: 'Logging out....', context: context, color: Colors.red);

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;

      openLoginScreen();
    });
  }

  openBatchStudentScreen(String batchId) {
    homeNavigator.openBatchStudentScreen(batchId);
  }

  openLoginScreen() {
    homeNavigator.openLoginScreen();
  }
}
