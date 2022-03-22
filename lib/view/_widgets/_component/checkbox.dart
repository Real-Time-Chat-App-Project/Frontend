import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/controllers/login/login_controllers.dart';

class checkboxRememberLogin extends StatefulWidget {
  const checkboxRememberLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<checkboxRememberLogin> createState() => _checkboxRememberLoginState();
}

class _checkboxRememberLoginState extends State<checkboxRememberLogin> {
  //
  LoginControllers _controller = Get.put(LoginControllers());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _controller.rememberSignedController.value,
          onChanged: (value) async {
            /*var box = await Hive.openBox('logindata');
            if (value == true) {
              // TODO::
              box.put('email', _controller.emailController.value.text);
              box.put('password', _controller.passwordController.value.text);

              debugPrint('trueeeee');
            }
            if (value == false) {
              // chekbox temizse boxu temizle
              await Hive.box('logindata').clear();
              debugPrint('cleared');
            }
            // işi bitince boxu kapat.
            box.close();*/
            setState(
              () {
                _controller.rememberSignedController.value = value!;
              },
            );
          },
        ),
        Text(
          'Remember me',
          style: TextStyle(color: Colors.black.withOpacity(.5)),
        ),
      ],
    );
  }
}
