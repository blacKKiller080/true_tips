import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileFirstItems extends StatefulWidget {
  String label;
  String path;
  Color colorItem;
  int alpha;
  void Function()? onTap;

  ProfileFirstItems(this.label, this.path, this.colorItem, this.alpha,
      {this.onTap});

  @override
  _ProfileFirstItemsState createState() => _ProfileFirstItemsState();
}

class _ProfileFirstItemsState extends State<ProfileFirstItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Container(
        child: Row(
          children: [
            Image.asset(
              widget.path,
              color: this.widget.colorItem,
            ),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.colorItem,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: 17, top: 17),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
                color: Color.fromARGB(widget.alpha, 165, 189, 199), width: 0.5),
          ),
        ),
      ),
    );
  }
}
