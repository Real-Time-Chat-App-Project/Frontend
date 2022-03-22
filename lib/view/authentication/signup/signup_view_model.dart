import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/signup/signup_controllers.dart';
import '../service/authentication.dart';

void signupProcess(BuildContext context) {
  SignUpControllers _controller = Get.put(SignUpControllers());
  // TODO:: check verified email
  //Authentication().checkEmailVerified(context);

  // password and confirmPassword must be the same and greater than 5
  if (_controller.passwordController.text.length > 5 &&
      _controller.passwordController.text ==
          _controller.confirmPasswordController.text) {
    Authentication().createUserWithEmailAndPassword(
        context: context,
        username: _controller.usernameController.text,
        email: _controller.emailController.text,
        password: _controller.passwordController.text);
  } else if (_controller.passwordController.text !=
      _controller.confirmPasswordController.text) {
    customFlushbar(context, message: 'Passwords must be the same');
  } else if (_controller.passwordController.text.length <= 5 &&
      _controller.confirmPasswordController.text.length <= 5) {
    // TODO::
    customFlushbar(context, message: 'Password must be at least 6 characters');
  } else {
    // TODO::
  }
}

Flushbar<dynamic> customFlushbar(BuildContext context, {message}) {
  return Flushbar(
    message: message,
    duration: const Duration(milliseconds: 1200),
    backgroundColor: Colors.blueGrey,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    isDismissible: true,
  )..show(context);
}
