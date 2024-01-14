import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/shared_prefs/user_shared_prefs.dart';
import 'package:hive_and_api_for_class/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
      ref.read(splashNavigatorProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs userSharedPrefs;
  final SplashNavigator splashNavigator;

  SplashViewModel(
    this.userSharedPrefs,
    this.splashNavigator,
  ) : super(null);

  init() async {
    final data = await userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          // Navigator.popAndPushNamed(context, AppRoute.loginRoute);
          openLoginScreen();
        } else {
          //Navigator.popAndPushNamed(context, AppRoute.homeRoute);
          openHomeScreen();
        }
      } else {
        openLoginScreen();
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // 10 digit
    int expirationTimestamp = decodedToken['exp'];
    // 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }

  // Navigate to login screen
  openLoginScreen() {
    splashNavigator.openLoginScreen();
  }

  openHomeScreen() {
    splashNavigator.openHomeScreen();
  }
}
