import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insulin_pump/screens/Connection/Connection.dart';
import 'package:insulin_pump/screens/MainScreen.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/screens/Authentication/SignUpScreen.dart';
import 'package:insulin_pump/screens/Authentication/ResetPassword.dart';

import 'package:insulin_pump/widgets/Button.dart';
import 'package:insulin_pump/widgets/RoundedInputField.dart';
import 'package:insulin_pump/widgets/SnackBarAlert.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/BgSignIn&Up.svg",
            fit: BoxFit.fill,
          ),
        ),
        Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "Sign In",
                        style: AppTheme.headerLg,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    RoundedInputField(
                      text: "Enter email",
                      hintText: "Email",
                      icon: Icons.email,
                      controller: _emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'E-mail is required.';
                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Invalid E-mail Address format.';

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    RoundedInputField(
                      text: "Enter password",
                      hintText: "Password",
                      isPasswordType: true,
                      icon: Icons.lock_outline,
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Password is required.';
                        if (value.length < 6)
                          return 'Password must be at least 6 characters.';

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    forgetPassword(context),
                    Button(context, "Sign In", () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConnectionScreen()));
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBarAlert.showErrorSnackBar(
                              "${error}",
                            ),
                          );
                      });
                    }),
                    signUpOption()
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
