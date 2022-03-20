import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          onChanged: (value) {
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
