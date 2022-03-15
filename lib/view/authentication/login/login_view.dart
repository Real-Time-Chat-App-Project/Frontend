import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/controllers/login/login_controllers.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';
import 'package:real_time_chat_app/view/authentication/service/email_authentication_service.dart';
import 'package:real_time_chat_app/view/authentication/service/google_authentication_service.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  LoginControllers _controller = Get.put(LoginControllers());

  @override
  Widget build(BuildContext context) {
    //
    bool _visibility = false;
    
    EmailAuthenticationService.authenticationWithEmailState();
    GoogleAuthenticationService.authenticationWithEmailState();

    return Scaffold(
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
                textFieldEnterUsername(),
                const SizedBox(height: 15),
                textFieldPassword(_visibility),
                const SizedBox(height: 20),
                textRecoveryPassword(),
                const SizedBox(height: 30),
                buttonLogin(),
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
    );
  }

  Row textRegisterNow(BuildContext context) {
    // TODO::
    //GoogleAuthenticationService.signOut(context: context);
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
        // TODO:: google sign in add
        //GoogleAuthenticationService.signUp();
        GoogleAuthenticationService.signInWithGoogle(context: context);
      },
      child: Image.asset('assets/icons/google.png'),
    );
  }

  SizedBox buttonLogin() {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          // TODOD::
          if (!(_formkey.currentState!.validate())) return;

          print(
              'username: ${_controller.usernameController.text}\npassword: ${_controller.passwordController.text}');
        },
        child: const Text('Login'),
        style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Row textRecoveryPassword() {
    return Row(
      children: [
        Expanded(child: Container()),
        InkWell(
          onTap: () {
            // TODO:: Password Recovery
          },
          child: Text(
            'Recovery Password',
            style: TextStyle(color: Colors.black.withOpacity(.5)),
          ),
        ),
      ],
    );
  }

  TextFormField textFieldPassword(bool _visibility) {
    return TextFormField(
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your password!";
        }
        return null;
      },
      // TODO:: input must be greater than 3 chararcters
      controller: _controller.passwordController,
      decoration: InputDecoration(
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

  TextFormField textFieldEnterUsername() {
    return TextFormField(
      // TODO
      validator: (val) {
        if (val!.trim() == "") {
          return "Check your username!";
        }
        return null;
      },
      // TODO:: input must be greater than 3 chararcters
      controller: _controller.usernameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //labelText: 'Enter Username',
        hintText: 'Enter Username',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
