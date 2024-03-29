import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/login/login_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/authentication.dart';

import '../../_widgets/_component/checkbox.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  LoginControllers _controller = Get.put(LoginControllers());

  late Box box;

  @override
  Widget build(BuildContext context) {
    Authentication().authStateChanges();

    return RawKeyboardListener(
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
            // when cliked enter login button is pressed
            loginOperation(context);
            debugPrint('cliked enter');
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          ///
          /// When clicking outside the textfields, hides keyboard
          ///
          FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
            focus.focusedChild?.unfocus();
          }
        },
        child: Scaffold(
          //
          // to control the widgets when the keyboard slides up and slides back down.
          // When true, the layout of the widgets scrolls when the keyboard is opened. And gives an error.
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              width: 350,
              // TODO
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO:: Enter tuşu giriş yapıyo
                    //RawKeyboardListener
                    Text(
                      'Hello Again!',
                      style: TextStyle(
                          fontSize: context.mediumValue,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Wellcome back you've",
                      style: TextStyle(color: Colors.black.withOpacity(.7)),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'been missed',
                      style: TextStyle(color: Colors.black.withOpacity(.7)),
                    ),
                    const SizedBox(height: 30),
                    textFieldEnterEmail(),
                    const SizedBox(height: 15),
                    textFieldPassword(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const checkboxRememberLogin(),
                        //checkboxRememberLogin(),
                        textRecoveryPassword(),
                      ],
                    ),

                    const SizedBox(height: 30),
                    buttonLogin(context),
                    const SizedBox(height: 25),
                    Divider(
                      color: Colors.black.withOpacity(.5),
                      thickness: .1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Login with',
                      style: TextStyle(color: Colors.black.withOpacity(.7)),
                    ),
                    const SizedBox(height: 35),
                    signInWithGoogle(context),
                    const SizedBox(height: 50),
                    textRegisterNow(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row textRegisterNow(BuildContext context) {
    // TODO::
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Not a member?'),
      TextButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: signUpPageRoute, data: '_');
            //Navigator.pushNamed(context, signUpPageRoute);
          },
          child: const Text('Register now'))
    ]);
  }

  InkWell signInWithGoogle(BuildContext context) {
    return InkWell(
      onTap: () {
        Authentication().signInWithGoogle(context);
      },
      child: Image.asset('assets/icons/google.png'),
    );
  }

  SizedBox buttonLogin(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () async {
          // TODOD::
          if (!(_formkey.currentState!.validate())) return;

          // from login_view_model
          loginOperation(context);

          print(
              'email: ${_controller.emailController.text}\npassword: ${_controller.passwordController.text}');
        },
        child: const Text('Login'),
        style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  InkWell textRecoveryPassword() {
    return InkWell(
      onTap: () {
        // TODO:: Password Recovery add
      },
      child: Text(
        'Recovery Password',
        style: TextStyle(color: Colors.black.withOpacity(.5)),
      ),
    );
  }

  Widget textFieldPassword() {
    return Obx(
      () => TextFormField(
        validator: (val) {
          if (val!.trim() == "") {
            return "Check your password!";
          }
          return null;
        },
        // TODO:: input must be greater than 3 chararcters
        controller: _controller.passwordController,
        obscureText: _controller.passwordVisibilityController.value,
        cursorColor: Colors.blueGrey,
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

  TextFormField textFieldEnterEmail() {
    return TextFormField(
      // TODO
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your email!";
        }
        return null;
      },
      cursorColor: Colors.blueGrey,
      // TODO:: input must be greater than 3 chararcters
      controller: _controller.emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Enter Username',
        hintText: 'Enter Email',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
