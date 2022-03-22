import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/signup/signup_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/authentication.dart';

import 'signup_view_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  //
  SignUpControllers _controller = Get.put(SignUpControllers());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///
        /// When clicking outside the textfields, hides keyboard
        ///
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          focus.focusedChild?.unfocus();
        }
      },
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          //
          // Allows interaction when the key is released.
          if (event is RawKeyDownEvent) {
            //
            // It continues to detect when the key is held down. We want it to be clicked once so the outer if condition is written
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              //
              // when cliked enter signup button pressed
              signupProcess(context);
              //debugPrint('cliked enter');
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              width: 350,
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: context.mediumValue,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Create an account, It's free",
                      style: TextStyle(color: Colors.black.withOpacity(.7)),
                    ),
                    const SizedBox(height: 40),
                    textFieldUsername(),
                    const SizedBox(height: 15),
                    textFieldEmail(),
                    const SizedBox(height: 15),
                    textFieldPassword(),
                    const SizedBox(height: 15),
                    textFieldConfirmPassword(),
                    const SizedBox(height: 75),
                    buttonSignUp(context),
                    const SizedBox(height: 25),
                    Divider(
                      color: Colors.black.withOpacity(.5),
                      thickness: .1,
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 50),
                    textLogin(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row textLogin(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Already have an account?'),
      TextButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: logInPageRoute, data: '_');
            //Navigator.pushNamed(context, logInPageRoute);
          },
          child: const Text('Log In'))
    ]);
  }

  ///
  /// // TODO:: signup butonuna spinner ekle
  ///
  SizedBox buttonSignUp(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          if (!(_formkey.currentState!.validate())) return;
          print(
              'username: ${_controller.usernameController.text}\nEmail: ${_controller.emailController.text}\nPassword: ${_controller.passwordController.text}');

          signupProcess(context);
        },
        child: const Text('Sign Up'),
        style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  TextFormField textFieldConfirmPassword() {
    return TextFormField(
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your Email!";
        }
        return null;
      },
      controller: _controller.confirmPasswordController,
      cursorColor: Colors.blueGrey,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget textFieldPassword() {
    return Obx(
      () => TextFormField(
        validator: (val) {
          if (val!.trim() == "") {
            return "Check your Password!";
          }
          return null;
        },
        controller: _controller.passwordController,
        cursorColor: Colors.blueGrey,
        obscureText: _controller.passwordVisibilityController.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _controller.passwordVisibilityController.value == false
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black.withOpacity(.2),
            ),
            onPressed: () {
              _controller.passwordVisibilityController.value =
                  !_controller.passwordVisibilityController.value;
            },
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Password',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  TextFormField textFieldEmail() {
    return TextFormField(
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your Email!";
        }
        return null;
      },
      controller: _controller.emailController,
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  TextFormField textFieldUsername() {
    return TextFormField(
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your username!";
        }
        return null;
      },
      controller: _controller.usernameController,
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Username',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
