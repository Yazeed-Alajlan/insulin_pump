import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? text;
  final String? hintText;
  final bool isPasswordType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final IconData? icon;
  final double? width;
  final String? font;

  const RoundedInputField({
    Key? key,
    this.text,
    this.hintText,
    this.isPasswordType = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.icon,
    this.width,
    this.font,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPasswordType,
        enableSuggestions: !isPasswordType,
        autocorrect: !isPasswordType,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),
          labelText: text,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        ),
      ),
    );
  }
}
