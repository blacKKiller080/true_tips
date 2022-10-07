import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/common_button.dart';
import 'package:true_tips_mobile/core/components/common_input.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/helper/input_helper.dart';
import 'package:true_tips_mobile/core/helper/modal_helper.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';
import 'package:true_tips_mobile/core/providers/auth_provider.dart';

class RegisterSecondScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.register_second;
  }

  @override
  _RegisterSecondScreenState createState() => _RegisterSecondScreenState();
}

class _RegisterSecondScreenState extends State<RegisterSecondScreen>
    with ModalHelper {
  String? code;
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var uid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/images/logo_mini.png',
                      width: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Введите код для подтверждения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '''Введите 4-значный код, который был отправлен на ваш номер''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Styles.k_text_tertiary_color,
                    ),
                  ),
                  Container(
                    height: 100,
                  ),
                  VerificationCode(
                    textStyle:
                        TextStyle(fontSize: 30.0, color: Styles.k_white_color),
                    keyboardType: TextInputType.number,
                    length: 4,
                    onCompleted: (String value) {
                      setState(() {
                        code = value;
                      });
                      Provider.of<AuthProvider>(context, listen: false)
                          .sendCodeAndGetToken(code!, uid)
                          .then((value) =>
                          SharedPreferencesHelper.setToken(value))
                          .then((value) => Navigator.pushNamed(
                          context, Routes.register_third))
                          .catchError((err) {
                        print(err);
                        error(context, "Неправильный код!");
                      });
                    },
                    digitsOnly: true,
                    onEditing: (bool value) {
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputContainer() => Container(
        child: VerificationCode(
          textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
          keyboardType: TextInputType.number,
          // in case underline color is null it will use primaryColor: Colors.red from Theme
          //underlineColor: Colors.amber,
          length: 4,
          // clearAll is NOT required, you can delete it
          // takes any widget, so you can implement your design

          onCompleted: (String value) {
            setState(() {});
          },
          onEditing: (bool value) {
            setState(() {});
            FocusScope.of(context).unfocus();
          },
        ),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(right: 10),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
