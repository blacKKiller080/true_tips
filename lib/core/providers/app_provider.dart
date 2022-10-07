import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_qr_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_wallet_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_transaction_screen.dart';

class AppProvider with ChangeNotifier {
  int _selectedIndex = 0;

  List<Widget> _options = <Widget>[
    ProfileQrScreen(),
    ProfileTransactionScreen(),
    ProfileWalletScreen(),
    ProfileScreen(),
  ];

  int get selectedIndex {
    return _selectedIndex;
  }

  Widget get selectedWidget {
    return _options[_selectedIndex];
  }

  int get length {
    return _options.length;
  }

  void setSelectedIndex(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setCurrentWidgetToWallet() {
    _selectedIndex = 2;
    notifyListeners();
  }

  void setCurrentWidgetToTransaction() {
    _selectedIndex = 1;
    notifyListeners();
  }
}
