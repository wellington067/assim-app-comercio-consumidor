import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/core/navigator.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class SplashScreenController {
  final BuildContext context;
  bool isFirstTime = false;
  SplashScreenController(this.context);
  final Logger _logger =
      Logger('Splash screen logger'); //a logger is always good to have
  final userStorage = UserStorage();

  void initApplication(Function onComplete) async {
    await Future.delayed(const Duration(seconds: 3), () {
      onComplete.call();
    });
    await configDefaultAppSettings();
  }

  Future configDefaultAppSettings() async {
    _logger.config('Configuring default app settings...');
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (await userStorage.userHasCredentials()) {
      navigatorKey.currentState!
          .popAndPushNamed(Screens.first);
    } else {
      // ignore: use_build_context_synchronously
      navigatorKey.currentState!
          .popAndPushNamed(Screens.signin);
    }
  }
}

