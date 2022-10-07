import 'package:flutter/gestures.dart';
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
import 'package:url_launcher/url_launcher.dart';

class RegisterFirstScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.register_first;
  }

  @override
  _RegisterFirstScreenState createState() => _RegisterFirstScreenState();
}

class _RegisterFirstScreenState extends State<RegisterFirstScreen>
    with ModalHelper {
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();
  bool isLoading = false;
  bool checkReadRequirements = false;

  //for form Validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'Регистрация',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                  ),
                  CommonInput(
                    "Введите номер телефона",
                    isLabelTextOn: true,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    type: InputType.PHONE,
                    formatters: [formatter],
                    onChanged: (val) {},
                    validator: (value) {
                      // returning the validator message here
                      return value.isEmpty ? "Please enter the message" : null;
                    },
                    onSubmitted: (val) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  Container(
                    height: 80,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      Row(
                        children: [
                          Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.green),
                              child: Container(
                                child: Checkbox(
                                    focusColor: Colors.lightBlue,
                                    activeColor: Colors.green,
                                    value: checkReadRequirements,
                                    onChanged: (newValue) {
                                      setState(() =>
                                          checkReadRequirements = newValue!);
                                    }),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: width * 0.7,
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      'Регистрируясь в приложении, Вы принимаете условия договора оферты и политики Truetips в отношении обработки персональных данныx, которые вы найдете нашем веб-сайте по ссылке ',
                                  children: [
                                    TextSpan(
                                      text: 'https://truetips.kz/',
                                      style: TextStyle(
                                          color: Styles.k_brand_primary_color),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launch('https://truetips.kz/');
                                        },
                                    )
                                  ]),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      SizedBox(height: 20.0),
                    ]),
                  ),
                  Column(
                    children: [
                      CommonButton(
                        child: isLoading
                            ? CircularProgressBar()
                            : Text('Продолжить'),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  if (checkReadRequirements != true) {
                                    error(context,
                                        'Пожалуйста, примите условия договора чтобы продолжить...');
                                    return;
                                  }
                                }
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isLoading = true;
                                });

                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .sendPhoneAndGetCode(
                                        "+" + formatter.getUnmaskedText())
                                    .then((value) => Navigator.pushNamed(
                                        context, Routes.register_second,
                                        arguments: value))
                                    .catchError((err) {
                                  error(context,
                                      'Произошла ошибка! Возможно вы превысили количество попыток!');
                                  print(err);
                                }).whenComplete(() => setState(() {
                                          isLoading = false;
                                        }));
                              },
                        margin: EdgeInsets.symmetric(vertical: 10),
                        success: true,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
