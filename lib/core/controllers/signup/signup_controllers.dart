import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpControllers extends GetxController {
  /*var _username = ''.obs;
  var _email = ''.obs;
  var _password = ''.obs;
  var _confirmPassword = ''.obs;*/
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var passwordVisibilityController = false.obs;

  //_username.value = usernameController.text;
  //get username => _username.value;
  /*get username => _username.value = usernameController.value.text;
  get email => _email.value;
  get password => _password.value;
  get confirmPassword => _confirmPassword.value;

  set username(newdata) => _username.value = newdata;
  set email(newdata) => _email.value = newdata;
  set password(newdata) => _password.value = newdata;
  set confirmPassword(newdata) => _confirmPassword.value = newdata;*/
}
