import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/constants/navigation/router.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/view/authentication/signup/signup_view.dart';

import 'view/authentication/login/login_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: logInPageRoute,

      theme: ThemeData(scaffoldBackgroundColor: Colors.grey.withOpacity(.2)),
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Messaging',
      home: const LoginView(),
    );
  }
}
