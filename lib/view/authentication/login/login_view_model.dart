import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/navigation/routes.dart';
import '../../../core/controllers/login/login_controllers.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../service/authentication.dart';

Future<void> loginOperation(BuildContext context) async {
  LoginControllers _controller = Get.put(LoginControllers());

  var flag = await Authentication().signInWithEmailAndPassword(context,
      _controller.emailController.text, _controller.passwordController.text);

  if (flag == true) {
    NavigationService.instance.navigateToPage(path: homePageRoute, data: '_');
  }

  //
  //
  // Hive operations
  var box = await Hive.openBox('logindata');

  ///
  /// if remember me is checked then put/save email and password to hive
  ///
  if (_controller.rememberSignedController.value) {
    box.put('email', _controller.emailController.value.text);
    box.put('password', _controller.passwordController.value.text);
  }

  ///
  /// if remember me is unchecked then clear the hive storage
  ///
  if (!_controller.rememberSignedController.value) {
    debugPrint('cleared');
    await Hive.box('logindata').clear();
  }

  box.close();

  /*NavigationService.instance
              .navigateToPage(path: homePageRoute, data: '_');*/
}
