import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';

import '../screens/user/login_screen.dart';
import '../screens/shared/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LoginScreen.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return null;
    }
  }
}
