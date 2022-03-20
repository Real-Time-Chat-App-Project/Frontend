import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/login/login_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/authentication_service.dart';
import 'package:real_time_chat_app/view/authentication/signup/signup_view.dart';

import 'core/controllers/signup/signup_controllers.dart';
import 'core/init/navigation/navigation_router.dart';
import 'firebase_options.dart';
import 'view/authentication/login/login_view.dart';
import 'view/authentication/login/login_view.dart';
import 'view/authentication/service/authentication.dart';
import 'view/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  User? _user;

  LoginControllers _controller = Get.put(LoginControllers());

  String? _route;

  Future<String?> _getCurrentRoute() async {
    bool? temp;

    await _controller.signedinController.listen((value) async {
      temp = await value;
      debugPrint('here: ${temp.toString()}');
    });

    setState(() {
      debugPrint('temp: ${temp}');

      if (temp == true) _route = homePageRoute;
      _route = logInPageRoute;
    });

    return _route;
  }

  void func() {
    _getCurrentRoute();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
  }

  //var _controller = LoginControllers();
  @override
  Widget build(BuildContext context) {
    return _getCurrentRoute == null
        ? Container()
        : GetMaterialApp(
            //
            navigatorKey: NavigationService.instance.navigatorKey,
            onGenerateRoute: NavigationRouter.instance.generateRoute,
            initialRoute: _route,

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
            // TODO:: signed in signed out control
            //_checkUser() != null ? LoginView() : SignUpView()
            //home:
            //    Center(child: Text(_controller.signedinController.value.toString())),
            /*home: Obx(() => _controller.signedinController.value
            ? LoginView()
            : const HomePage()),*/
          );
  }
}
