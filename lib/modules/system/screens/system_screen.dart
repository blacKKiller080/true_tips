import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/providers/app_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class SystemScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.system;
  }

  @override
  _SystemScreenState createState() => _SystemScreenState();

  @override
  bool isInitialRoute() {
    return false;
  }
}

class _SystemScreenState extends State<SystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Provider.of<AppProvider>(context).selectedWidget,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (int index) {
            Provider.of<AppProvider>(context, listen: false)
                .setSelectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "",
            ),
          ],
          currentIndex: Provider.of<AppProvider>(context).selectedIndex,
          unselectedItemColor: Color.fromARGB(255, 165, 189, 199),
          selectedItemColor: Color.fromARGB(255, 32, 178, 93),
        ),
      ),
    );
  }
}
