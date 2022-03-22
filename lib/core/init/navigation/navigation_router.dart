import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/view/authentication/login/login_view.dart';
import 'package:real_time_chat_app/view/authentication/signup/signup_view.dart';
import 'package:real_time_chat_app/view/home/home_view.dart';

class NavigationRouter {
  //
  static NavigationRouter _instance = NavigationRouter._init();
  static NavigationRouter get instance => _instance;

  NavigationRouter._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUpPageRoute:
        return _getPageRoute(SignUpView());
      case logInPageRoute:
        return _getPageRoute(LoginView());
      case homePageRoute:
        return _getPageRoute(HomePage());
      default:
        return _getPageRoute(LoginView());
    }
  }

  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }
}
