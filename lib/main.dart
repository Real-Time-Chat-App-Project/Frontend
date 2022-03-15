import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';

import 'core/controllers/signup/signup_controllers.dart';
import 'core/init/navigation/navigation_router.dart';
import 'firebase_options.dart';
import 'view/authentication/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRouter.instance.generateRoute,
      initialRoute: logInPageRoute,

      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffff4eef2),
        //scaffoldBackgroundColor: Colors.grey.withOpacity(.2),
        //scaffoldBackgroundColor: Colors.amber,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Messaging',
      home: LoginView(),
    );
  }
}
