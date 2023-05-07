import 'package:insulin_pump/screens/Authentication/SignInScreen.dart';
import 'package:insulin_pump/screens/Connection/Connection.dart';
import 'package:insulin_pump/widgets/Button.dart';
import 'package:insulin_pump/widgets/RoundedInputField.dart';
import 'package:insulin_pump/widgets/SnackBarAlert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordConfirmationTextController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                        "Create New Account",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                          return 'Password is required.';
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
                      text: "Password",
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
                      height: 24,
                    ),
                    RoundedInputField(
                      text: "Confirm Password",
                      hintText: "Confirm Password",
                      isPasswordType: true,
                      icon: Icons.lock_outline,
                      controller: _passwordConfirmationTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Confirmation password is required.';
                        if (_passwordConfirmationTextController.text !=
                            _passwordTextController.text)
                          return 'Passwords do not match.';

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(context, "Sign Up", () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
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
                    signInOption()
                  ],
                ),
              ))),
        ),
      ]),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            "Sign In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
