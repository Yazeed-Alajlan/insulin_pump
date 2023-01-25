import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

class SnackBarAlert {
  static SnackBar showErrorSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: AppTheme.successColor,
      duration: Duration(seconds: 2),
    );
  }
}
