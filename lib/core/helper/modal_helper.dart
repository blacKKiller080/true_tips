import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';

mixin ModalHelper {
  void success(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Styles.k_success_color,
    ));
  }

  void error(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Styles.k_error_color,
    ));
  }

  void info(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Styles.k_white_color,
    ));
  }
}
