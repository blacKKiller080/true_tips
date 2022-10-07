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
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/models/responses/fee_response.dart';
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/providers/transaction_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class ProfileWalletScreen extends StatefulWidget implements Navigateable {
  @override
  _ProfileWalletScreenState createState() => _ProfileWalletScreenState();

  @override
  String getName() {
    return Routes.profile_second;
  }
}

class _ProfileWalletScreenState extends State<ProfileWalletScreen>
    with ModalHelper {
  var moneyController = TextEditingController();

  MaskTextInputFormatter formatter = InputHelper.bankTextInputFormatter();
  UserEntity? user;
  FeeResponse? fee;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadData();
    });
  }

  loadData() {
    Provider.of<ProfileProvider>(context, listen: false)
        .currentUser()
        .then((value) {
      setState(() {
        user = value;
      });

      return Provider.of<TransactionProvider>(context, listen: false).fee();
    }).then((value) => setState(() {
              fee = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: user == null
          ? Center(child: CircularProgressBar())
          : Container(
              margin: EdgeInsets.only(bottom: 20, left: 20, top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'ВАШ БАЛАНС',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/tenge.png'),
                          Text(
                            user!.getBalance().toString(),
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 32, 178, 93),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 100,
                          child: Container(
                            child: Image.asset(
                              'assets/images/profile_second1.png',
                              //alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 50),
                                height: 220,
                                child: CommonInput(
                                  "Введите сумму",
                                  fontWeight: FontWeight.w600,
                                  customColor: Color.fromARGB(255, 11, 14, 19),
                                  isLabelTextOn: true,
                                  margin: EdgeInsets.only(top: 12),
                                  controller: moneyController,
                                  type: InputType.NUMBER_WITH_OPTIONS,
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  onSubmitted: (val) {
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 20, right: 20),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: Color.fromARGB(102, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '''К зачислению:   ''',
                              style: TextStyle(
                                color: Styles.k_text_tertiary_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '''${getMoneyToPut()} тг''',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                        Row(
                          children: [
                            Text(
                              '''Комиссия:          ''',
                              style: TextStyle(
                                color: Styles.k_text_tertiary_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '''${getCommission()} тг''',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CommonButton(
                    disabled: getMoneyToPut() > user!.getBalance() ||
                        moneyController.text.isEmpty ||
                        getMoneyToPut() <= 0 ||
                        user!.getBalance() <= 0,
                    child: isLoading ? CircularProgressBar() : Text('Вывести'),
                    onPressed: isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .payroll(user!.uid, moneyController.text)
                                .then((value) {
                                  return Navigator.of(context).pushNamed(
                                      Routes.web_view,
                                      arguments: value.redirectUrl);
                                })
                                .then((value) {
                                  if (value is bool) {
                                    if (value) {
                                      success(
                                          context, 'Перевод успешно совершен!');
                                    }
                                  }
                                })
                                .onError((err, stack) {
                                  print(err);
                                  error(context, 'Произошла ошибка!');
                                })
                                .whenComplete(() => loadData())
                                .whenComplete(() => setState(() {
                                      isLoading = false;
                                    }));
                          },
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 20),
                    success: true,
                  ),
                ],
              ),
            ),
    );
  }

  double getMoney() {
    return double.parse(
        moneyController.text.isEmpty ? "0.0" : moneyController.text);
  }

  double getMoneyToPut() {
    return getMoney() - getCommission();
  }

  double getCommission() {
    if (fee == null) {
      return 0;
    }

    if (getMoney() <= fee!.payrollMinAmount) {
      return fee!.payrollFee.toDouble();
    } else {
      return getMoney() * fee!.payrollFeePercent / 100;
    }
  }

  @override
  void dispose() {
    super.dispose();
    moneyController.dispose();
  }
}
