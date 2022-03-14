import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:real_time_chat_app/core/constants/navigation/routes.dart';

import '../../_widgets/_component/text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    bool _visibility = false;

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello Again!',
                style: TextStyle(
                    fontSize: context.mediumValue, fontWeight: FontWeight.bold),
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
              signInWithGoogle(),
              const SizedBox(height: 50),
              textRegisterNow(context),
            ],
          ),
        ),
      ),
    );
  }

  Row textRegisterNow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Not a member?'),
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, signUpPageRoute);
            // TODO:: go register page
          },
          child: const Text('Register now'))
    ]);
  }

  InkWell signInWithGoogle() {
    return InkWell(
      onTap: () {
        // TODO:: google sign in add
      },
      child: Image.asset('assets/icons/google.png'),
    );
  }

  SizedBox buttonLogin() {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () {},
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

  TextField textFieldEnterUsername() {
    return TextField(
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
