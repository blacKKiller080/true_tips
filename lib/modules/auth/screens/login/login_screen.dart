import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/common_button.dart';
import 'package:true_tips_mobile/core/components/common_input.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/helper/input_helper.dart';
import 'package:true_tips_mobile/core/helper/modal_helper.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/http/custom_exception.dart';
import 'package:true_tips_mobile/core/providers/auth_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class LoginScreen extends StatefulWidget implements Navigateable {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  @override
  String getName() {
    return Routes.login;
  }
}

class _LoginScreenState extends State<LoginScreen> with ModalHelper {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  bool isLoginButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
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
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Добро пожаловать!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        'assets/images/profile.png',
                        width: 80,
                      ),
                    ),
                    Text('Получатель чаевых'),
                    CommonInput(
                      "Введите номер телефона",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.PHONE,
                      controller: phoneController,
                      formatters: [formatter],
                      onChanged: (val) {
                        if (val.length == 18) {
                          FocusScope.of(context).nextFocus();
                        }
                        checkInputs(val);
                      },
                    ),
                    CommonInput(
                      "Введите пароль",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.PASSWORD,
                      controller: passwordController,
                      onChanged: (val) => checkInputs(val),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(color: Styles.k_success_color),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.restore_pass_first);
                      },
                    ),
                    CommonButton(
                      child: Text('Войти'),
                      onPressed: () async => await login(),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      disabled: isLoginButtonDisabled,
                      success: true,
                    ),
                    CommonButton(
                      child: Text('Зарегистрироваться'),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register_first);
                      },
                      margin: EdgeInsets.symmetric(vertical: 10),
                      success: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    var login = formatter.getUnmaskedText();
    var password = passwordController.text;
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login("+" + login, password);
      Navigator.pushReplacementNamed(context, Routes.system);
    } on BaseException catch (e) {
      print(e.getErrorCode());
      error(context, 'Неправильный логин или пароль!');
    }
  }

  void checkInputs(String val) {
    setState(() {
      isLoginButtonDisabled = !(phoneController.text.length > 0 &&
          passwordController.text.length > 0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
