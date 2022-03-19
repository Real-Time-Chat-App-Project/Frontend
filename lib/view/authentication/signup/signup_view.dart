import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/signup/signup_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/email_authentication_service.dart';

import '../../_widgets/_component/text_field.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  //
  SignUpControllers _controller = Get.put(SignUpControllers());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //
    bool _visibility = false;

    return Scaffold(
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
                textFieldPassword(_visibility),
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
          //AuthenticationService.signUp(
          //'emincingoz@gmail.com', '123456');
          //generateRoute(signUpPageRoute);
          print(
              'username: ${_controller.usernameController.text}\nEmail: ${_controller.emailController.text}\nPassword: ${_controller.passwordController.text}');

          // password and confirmPassword must be the same and greater than 5
          if (_controller.passwordController.text.length > 6 &&
              _controller.passwordController.text ==
                  _controller.confirmPasswordController.text) {
            EmailAuthenticationService.signUp(
                _controller.usernameController.text,
                _controller.emailController.text,
                _controller.passwordController.text);
          } else if (_controller.passwordController.text !=
              _controller.confirmPasswordController.text) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Passwords must be the same'),
              backgroundColor: Colors.blueGrey,
              duration: Duration(milliseconds: 1100),
            ));
          } else if (_controller.passwordController.text.length <= 5 &&
              _controller.confirmPasswordController.text.length <= 5) {
            // TODO::
            //return SnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Password must be at least 6 letters'),
              backgroundColor: Colors.blueGrey,
              duration: Duration(milliseconds: 1100),
            ));
          } else {
            // TODO::
          }
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Password',
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  TextFormField textFieldPassword(bool _visibility) {
    return TextFormField(
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your Password!";
        }
        return null;
      },
      controller: _controller.passwordController,
      // TODO::
      // Şifre gizlemek için bunu da SignupController içerisinde tanımlayabilirsin. Butonun basılmış olma durumuna göre değişir.
      obscureText: true,
      decoration: InputDecoration(
        //suffix: ,
        suffixIcon: IconButton(
          icon: Icon(
            _visibility == false ? Icons.visibility : Icons.visibility_off,
            color: Colors.black.withOpacity(.2),
          ),
          onPressed: () {
            ///
            /// TODO::Riverpod ile takip edilecek. Visibility değişmesi durumunda textfielda yansıtacak.
            ///
          },
        ),
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Password',
        hintText: 'Password',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Enter Username',
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
      //controller: ,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Enter Username',
        hintText: 'Username',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
