import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/core/components/common_button.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class RegisterFinalScreen extends StatefulWidget implements Navigateable {
  @override
  _RegisterFinalScreenState createState() => _RegisterFinalScreenState();

  @override
  String getName() {
    return Routes.register_final;
  }
}

class _RegisterFinalScreenState extends State<RegisterFinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/images/logo_mini.png',
                  width: 80,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/success.png',
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'assets/images/checkmark.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                  ),
                  Text(
                    '''Поздравляем вы успешно прошли регистрацию!''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              CommonButton(
                child: Text('Продолжить'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.system, (Route<dynamic> route) => false);
                },
                margin: EdgeInsets.symmetric(vertical: 10),
                success: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
