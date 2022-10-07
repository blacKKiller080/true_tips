import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/models/entities/transaction_entity.dart';
import 'package:true_tips_mobile/core/providers/transaction_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/components/TransactionCard.dart';

class ProfileTransactionScreen extends StatefulWidget implements Navigateable {
  @override
  _ProfileTransactionScreenState createState() =>
      _ProfileTransactionScreenState();

  @override
  String getName() {
    return Routes.profile_third;
  }
}

class _ProfileTransactionScreenState extends State<ProfileTransactionScreen> {
  List<TransactionEntity> transactions = [];
  int limit = 30;
  int page = 0;
  String date = '';
  bool listEnd = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadTransactions();
    });
  }

  loadTransactions({bool empty = false}) {
    if (empty) {
      page = 0;
    }
    Provider.of<TransactionProvider>(context, listen: false)
        .transactions(date: date, limit: limit, offset: page * limit)
        .then((value) => setState(() {
              listEnd = value.results.isEmpty;
              transactions = empty
                  ? [...value.results]
                  : [...transactions, ...value.results];
            }));
    page++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dateChooseButton('Сегодня', 'today'),
                  dateChooseButton('Неделя', 'week'),
                  dateChooseButton('Месяц ', 'month'),
                ],
              ),
            ),
            transactions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(100),
                    child: Text(
                      'Нет данных',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index < transactions.length) {
                          return TransactionCard(transactions[index]);
                        } else {
                          loadTransactions();
                          return Text(
                            'Загрузка...',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                      itemCount: transactions.length + (listEnd ? 0 : 1),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }


  bool success = false;

  Widget dateChooseButton(String buttonName, String value) => GestureDetector(
        onTap: () {
          setState(() {
            if (date != value) {
              date = value;
            } else {
              date = '';
            }
          });
          loadTransactions(empty: true);
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getColor(value),
          ),
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

  Color getColor(buttonName) {
    Color color;
    if (date == buttonName) {
      color = Color.fromARGB(255, 32, 178, 93);
    } else {
      color = Color.fromARGB(200, 32, 178, 93);
    }
    return color;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
