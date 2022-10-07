import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/core/constants/styles.dart';
import 'package:true_tips_mobile/core/models/entities/transaction_entity.dart';

class TransactionCard extends StatelessWidget {
  TransactionEntity item;

  TransactionCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 25, top: 5, bottom: 15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Color.fromARGB(255, 165, 189, 199),
                  ),
                  Text(
                    item.getDate(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 165, 189, 199),
                    ),
                  ),
                  // Icon(
                  //   Icons.location_on_outlined,
                  //   color: Color.fromARGB(255, 165, 189, 199),
                  // ),
                  // Text(
                  //   'Almaty',
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: Color.fromARGB(255, 165, 189, 199),
                  //   ),
                  // ),
                ],
              ),
              Text(
                '${item.amount}тг',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 178, 93),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 17, bottom: 10),
            child: Text(
              item.getComment(),
              //textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Styles.k_black_color,
              ),
            ),
          ),
          Row(
            children: getStars(),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  List<Widget> getStars() {
    List<Widget> stars = [];
    for (int i = 0; i < item.rating; i++) {
      stars.add(Icon(
        Icons.star_rounded,
        color: Color.fromARGB(255, 32, 178, 93),
      ));
    }

    return stars;
  }
}
