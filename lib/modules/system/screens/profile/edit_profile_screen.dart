import 'dart:developer';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/circular_progress_bar.dart';
import 'package:true_tips_mobile/core/components/common_button.dart';
import 'package:true_tips_mobile/core/components/common_input.dart';
import 'package:true_tips_mobile/core/helper/input_helper.dart';
import 'package:true_tips_mobile/core/helper/modal_helper.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class EditProfileScreen extends StatefulWidget implements Navigateable {
  @override
  String getName() {
    return Routes.edit_profile;
  }

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with ModalHelper {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var dateController = TextEditingController();
  var workLocationController = TextEditingController();
  var cityController = TextEditingController();
  var commentController = TextEditingController();
  var dateFormatter = InputHelper.dateTextInputFormatter();


  late UserEntity userEntity;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      userEntity = ModalRoute.of(context)!.settings.arguments as UserEntity;
      nameController.text = userEntity.firstName;
      surnameController.text = userEntity.lastName;
      dateController.text = userEntity.birthDate ?? "";
      workLocationController.text = userEntity.workPlace;
      cityController.text = userEntity.city;
      commentController.text = userEntity.comment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Редактировать профиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    CommonInput(
                      "Имя",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.TEXT,
                      controller: nameController,
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onChanged: (val) {},
                      onSubmitted: (val) => FocusScope.of(context).unfocus(),
                    ),
                    CommonInput(
                      "Фамилия",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.TEXT,
                      controller: surnameController,
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onChanged: (val) {},
                      onSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CommonInput(
                      "ДД.ММ.ГГГГ",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.NUMBER_WITH_OPTIONS,
                      controller: dateController,
                      formatters: [dateFormatter],
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CommonInput(
                      "Место работы",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.TEXT,
                      controller: workLocationController,
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onChanged: (val) {},
                      onSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CommonInput(
                      "Город",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.TEXT,
                      controller: cityController,
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onChanged: (val) {},
                      onSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CommonInput(
                      "Коммент",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      type: InputType.TEXT,
                      controller: commentController,
                      contentPaddingVertical: 21.0,
                      borderRadius: 15,
                      onChanged: (val) {},
                      onSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
                CommonButton(
                  child: isLoading ? CircularProgressBar() : Text('Обновить'),
                  onPressed: () {
                    userEntity.comment = commentController.text;
                    userEntity.city = cityController.text;
                    userEntity.birthDate = dateController.text;
                    userEntity.workPlace = workLocationController.text;
                    userEntity.lastName = surnameController.text;
                    userEntity.firstName = nameController.text;
                    setState(() {
                      isLoading = true;
                    });
                    Provider.of<ProfileProvider>(context, listen: false)
                        .updateProfile(userEntity)
                        .then((value) {
                      print(value);
                      success(context, 'Данные профиля обновлены!');
                    }).catchError((err, stackTrace) {
                      print(err);
                      print(stackTrace);
                      error(context, 'Произошла ошибка!');
                    }).whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  },
                  margin: EdgeInsets.symmetric(vertical: 10),
                  success: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    dateController.dispose();
    workLocationController.dispose();
    cityController.dispose();
    commentController.dispose();
  }
}
