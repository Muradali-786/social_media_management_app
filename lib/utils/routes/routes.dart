import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashBoord/dash_board.dart';
import 'package:tech_media/view/dashBoord/profile/profile_screen.dart';
import 'package:tech_media/view/dashBoord/user_list/user_list.dart';
import 'package:tech_media/view/forgot_password/forgot_password_screen.dart';
import 'package:tech_media/view/home_screen.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:

        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen(data: settings.arguments as Map));
      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) =>const  DashBoardScreen());
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteName.userListScreen:
        return MaterialPageRoute(builder: (_) => const UserList());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}