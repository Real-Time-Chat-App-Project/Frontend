import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';
import 'package:real_time_chat_app/core/init/navigation/navigation_service.dart';

import '../../_widgets/_component/text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    bool _visibility = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: context.mediumValue, fontWeight: FontWeight.bold),
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
              buttonSignUp(),
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

  SizedBox buttonSignUp() {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          //generateRoute(signUpPageRoute);
        },
        child: const Text('Sign Up'),
        style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  TextField textFieldConfirmPassword() {
    return TextField(
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

  TextField textFieldPassword(bool _visibility) {
    return TextField(
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

  TextField textFieldEmail() {
    return TextField(
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

  TextField textFieldUsername() {
    return TextField(
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
