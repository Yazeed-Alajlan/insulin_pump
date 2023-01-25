import 'package:flutter/material.dart';

class InjectionScreen extends StatefulWidget {
  const InjectionScreen({
    required this.animationController,
    super.key,
  });
  final AnimationController animationController;

  @override
  State<InjectionScreen> createState() => _InjectionScreenState();
}

class _InjectionScreenState extends State<InjectionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Hello from injection"),
    );
  }
}
