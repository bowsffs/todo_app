import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      required this.circleIcon,
      required this.circleButtonFunc,
      this.iconHeight,
      this.iconSize,
      this.iconWidth})
      : super(key: key);

  final double? iconHeight;
  final double? iconWidth;
  final double? iconSize;
  final IconData circleIcon;
  final Function() circleButtonFunc;

  @override
  Widget build(BuildContext context) {
    // return CircleAvatar(
    //   radius: iconWidth ?? 15.0,
    //   backgroundColor: Colors.white,
    //   child: InkWell(
    //     onTap: circleButtonFunc,
    //     child: Icon(
    //       circleIcon,
    //       size: iconHeight ?? 20.0,
    //       color: AppColor.currentAppColor,
    //     ),
    //   ),
    // );
    return ClipOval(
      child: Material(
        color: Colors.white, // Button color
        child: InkWell(
          splashColor:
              AppColor.currentAppColor.withOpacity(0.6), // Splash color
          onTap: circleButtonFunc,
          child: SizedBox(
            width: iconWidth ?? 27,
            height: iconHeight ?? 27,
            child: Icon(
              circleIcon,
              color: AppColor.currentAppColor,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }
}
