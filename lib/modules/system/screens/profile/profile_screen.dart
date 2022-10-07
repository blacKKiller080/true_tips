
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/circular_progress_bar.dart';
import 'package:true_tips_mobile/core/components/profile_first_items.dart';
import 'package:true_tips_mobile/core/components/round_image.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/providers/app_provider.dart';
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';


class ProfileScreen extends StatefulWidget implements Navigateable {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  @override
  String getName() {
    return Routes.profile_first;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserEntity? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => loadUser());
  }

  void loadUser() {
    Provider.of<ProfileProvider>(context, listen: false).currentUser().then(
          (value) => setState(() {
            user = value;
          }),
        );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: user == null
          ? Center(child: CircularProgressBar())
          : Container(
              margin:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 150),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Профиль',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 8,
                          child: Row(
                            children: [
                              Container(
                                child: RoundedImage(
                                  width: 104,
                                  height: 104,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user!.getFullName(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 11, 14, 19),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    user!.getWorkPlace(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 32, 178, 93),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ProfileFirstItems(
                          '   Редактировать профиль',
                          'assets/images/Edit.png',
                          Colors.white,
                          255,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.edit_profile,
                                    arguments: user)
                                .then((value) => loadUser());
                          },
                        ),
                        ProfileFirstItems(
                          '   Сменить пароль',
                          'assets/images/lock.png',
                          Colors.white,
                          255,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.change_pass);
                          },
                        ),
                        ProfileFirstItems(
                          '   История транзакций',
                          'assets/images/bill.png',
                          Colors.white,
                          255,
                          onTap: () {
                            Provider.of<AppProvider>(context, listen: false)
                                .setCurrentWidgetToTransaction();
                          },
                        ),
                        ProfileFirstItems(
                          '   Кошелёк',
                          'assets/images/pouch.png',
                          Colors.white,
                          255,
                          onTap: () {
                            Provider.of<AppProvider>(context, listen: false)
                                .setCurrentWidgetToWallet();
                          },
                        ),
                        ProfileFirstItems(
                          '   Выйти',
                          'assets/images/Logout.png',
                          Color.fromARGB(255, 32, 178, 93),
                          0,
                          onTap: () {
                            SharedPreferencesHelper.removeAll()
                                .then((value) =>
                                    Navigator.pushNamed(context, Routes.login))
                                .whenComplete(() => print('Logged out'));
                          },
                        ),
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
            ),
    );
  }
}
