import 'package:insulin_pump/firebase_options.dart';
import 'package:insulin_pump/screens/MainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/Authentication/SignInScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Type 1 diabetes app',
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
