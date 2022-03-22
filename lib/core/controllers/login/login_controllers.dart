import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginControllers extends GetxController {
  //var _username = ''.obs;
  //var _password = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var passwordVisibilityController = false.obs;
  var signedinController = false.obs;
  var rememberSignedController = false.obs;

  /*get username => _username;
  get password => _password;

  set username(newdata) => _username = newdata;
  set password(newdata) => _password = newdata;*/
}
