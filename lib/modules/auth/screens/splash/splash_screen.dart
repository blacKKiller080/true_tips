import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class SplashScreen extends StatefulWidget implements Navigateable {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  @override
  String getName() {
    return Routes.initial;
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      var token = await SharedPreferencesHelper.getToken();
      if (token != null) {
        Navigator.pushReplacementNamed(context, Routes.system);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
