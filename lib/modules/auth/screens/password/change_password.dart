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
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class ChangePasswordScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.change_pass;
  }

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with ModalHelper {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var newRepeatedPasswordController = TextEditingController();

  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
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
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Смена пароля',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CommonInput(
                    "Введите старый пароль",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    type: InputType.PASSWORD,
                    controller: oldPasswordController,
                    onChanged: (val) => setState(() {}),
                    onSubmitted: (val) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  CommonInput(
                    "Введите новый пароль",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    type: InputType.PASSWORD,
                    controller: newPasswordController,
                    onChanged: (val) => setState(() {}),
                    onSubmitted: (val) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  CommonInput(
                    "Подтверрдите новый пароль",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    type: InputType.PASSWORD,
                    controller: newRepeatedPasswordController,
                    onChanged: (val) => setState(() {}),
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
                disabled: !isPasswordValid(),
                child: Text('Продолжить'),
                onPressed: () {
                  if (oldPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Введите старый пароль")));
                    return;
                  }
                  if (newPasswordController.text !=
                          newRepeatedPasswordController.text ||
                      newRepeatedPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Ваши пароли не совпадают")));
                    return;
                  }
                  Provider.of<ProfileProvider>(context, listen: false)
                      .updatePassword(oldPasswordController.text,
                          newPasswordController.text)
                      .then((value) {
                    success(context, 'Ваш пароль успешно изменен!');
                    Navigator.of(context).pop();
                  }).onError((err, stack) {
                    print(err);
                    oldPasswordController.text = '';
                    newPasswordController.text = '';
                    newRepeatedPasswordController.text = '';
                    error(context, 'Старый пароль не совпадает или новый пароль слишком простой!');
                  });
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

  bool isPasswordValid() {
    return !(oldPasswordController.text.isEmpty ||
        newPasswordController.text != newRepeatedPasswordController.text ||
        newRepeatedPasswordController.text.isEmpty);
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newRepeatedPasswordController.dispose();
  }
}
