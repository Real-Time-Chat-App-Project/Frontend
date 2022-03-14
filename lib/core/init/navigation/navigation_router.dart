import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/view/authentication/login/login_view.dart';
import 'package:real_time_chat_app/view/authentication/signup/signup_view.dart';

class NavigationRouter {
  //
  static NavigationRouter _instance = NavigationRouter._init();
  static NavigationRouter get instance => _instance;

  NavigationRouter._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUpPageRoute:
        return _getPageRoute(const SignUpView());
      case logInPageRoute:
        return _getPageRoute(const LoginView());
      default:
        return _getPageRoute(const LoginView());
    }
  }

  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }
}
