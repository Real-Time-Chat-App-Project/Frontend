import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('HomePage'),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                //Authentication().signOut();
                NavigationService.instance
                    .navigateToPage(path: logInPageRoute, data: '_');
              },
              child: const Text('Login Page'))
        ],
      )),
    );
  }
}
