import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:true_tips_mobile/core/components/circular_progress_bar.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/helper/navigateable.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/routes/routes.dart';

class ProfileQrScreen extends StatefulWidget implements Navigateable {
  @override
  _ProfileQrScreenState createState() => _ProfileQrScreenState();

  @override
  String getName() {
    return Routes.profile_fourth;
  }
}

class _ProfileQrScreenState extends State<ProfileQrScreen> {
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    final bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<UserEntity>(
          future: Provider.of<ProfileProvider>(context).currentUser(),
          builder: (context, AsyncSnapshot<UserEntity> data) {
            if (!data.hasData) {
              return Center(
                child: CircularProgressBar(
                  color: Styles.k_main_color,
                ),
              );
            }
            UserEntity user = data.data!;
            return Container(
              margin:
                  EdgeInsets.only(right: 28, left: 28, top: 98, bottom: 104),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(100, 52, 50, 50)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '''Ваш персональный \n QR-код''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Styles.k_text_tertiary_color,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      key: globalKey,
                      child: QrImage(
                        data: user.getQR(),
                        size: 0.3 * bodyHeight,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 0.7 * bodyWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 90, 88, 88),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  user.getQR(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: user.getQR()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Скопировано в буфер обмена")));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color.fromARGB(255, 32, 178, 93),
                                  ),
                                  padding: EdgeInsets.all(7),
                                  child: Icon(
                                    Icons.content_copy,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
