import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/login/login_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';

import 'core/init/navigation/navigation_router.dart';
import 'firebase_options.dart';
import 'view/authentication/service/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  //await Hive.openBox('logindata');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  //LoginControllers _controller = Get.put(LoginControllers());
  Box? box;

  Future<String> _getCurrentRoute() async {
    //
    // TODO:: if signed out then clear the hive storage. Not here where it needs to be. REMEMBER
    box = await Hive.openBox('logindata');

    var email = box?.get('email');

    var password = box?.get('password');

    String? _route;

    if (email != null && password != null) {
      _route = homePageRoute;
    } else {
      _route = logInPageRoute;
    }

    return _route;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getCurrentRoute(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container();
        else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            debugPrint('data : ${snapshot.data}');
            return GetMaterialApp(
              //
              navigatorKey: NavigationService.instance.navigatorKey,
              onGenerateRoute: NavigationRouter.instance.generateRoute,
              initialRoute: snapshot.data,

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
            );
          }
        }
      },
    );
  }
}
