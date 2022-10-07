import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/circular_progress_bar.dart';
import 'package:true_tips_mobile/core/components/common_button.dart';
import 'package:true_tips_mobile/core/components/common_input.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/helper/input_helper.dart';
import 'package:true_tips_mobile/core/helper/modal_helper.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/providers/auth_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class RegisterThirdScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.register_third;
  }

  @override
  _RegisterThirdScreenState createState() => _RegisterThirdScreenState();
}

class _RegisterThirdScreenState extends State<RegisterThirdScreen>
    with ModalHelper {
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  bool isLoading = false;

  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  getText() {
    return repeatPasswordController.text;
  }

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
                    margin: EdgeInsets.only(top: 20, bottom: 20, right: 190),
                    child: Text(
                      'Создать пароль',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CommonInput(
                    "Введите новый пароль",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    type: InputType.PASSWORD,
                    controller: passwordController,
                    onChanged: (val) {},
                    onSubmitted: (val) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  CommonInput(
                    "Подтвердите новый пароль",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    type: InputType.PASSWORD,
                    controller: repeatPasswordController,
                    onSubmitted: (val) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  Text(
                    '''Пароль должен состоять не менее чем из 8 и не более 30 символов.

В пароле обязательно должны присутствовть буквы нижнего (от a до z) и верхнего (от A до Z) регистра и цифры от (1 до 9).''',
                    style: TextStyle(color: Styles.k_text_tertiary_color),
                  ),
                ],
              ),
              CommonButton(
                child: isLoading
                    ? CircularProgressBar()
                    : Text('Сохранить'),
                onPressed: isLoading
                    ? null
                    : () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  if (passwordController.text == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Введите пароль")));

                    return;
                  }

                  if (passwordController.text.length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Пароль должен быть больше или равен 8, состоят из символов и заглавных букв")));

                    return;
                  }

                  if (passwordController.text !=
                      repeatPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Пароль не совпадает")));

                    return;
                  }
                  String password = passwordController.text;
                  Provider.of<AuthProvider>(context, listen: false)
                      .setPassword(password)
                      .then((value) => Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.register_final,
                          (Route<dynamic> route) => false,
                          arguments: passwordController.text))
                      .catchError((err) {
                    print(err);
                    error(context, 'Пароль слишком простой!');
                  }).whenComplete(() => print('Password updated')).whenComplete(() => setState(() {
                    isLoading = false;
                  }));
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

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }
}
