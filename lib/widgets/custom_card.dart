import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:todo_app/modules/app_color.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key, required Widget child})
      : _child = child,
        super(key: key);
  final Widget _child;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColor.currentAppColor,
      elevation: 2,
      margin: kCardMargin,
      child: Container(
        padding: kCardInnerMargin,
        child: widget._child,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: AppColor.currentAppColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
