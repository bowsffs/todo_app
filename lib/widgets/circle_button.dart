import 'package:flutter/material.dart';
import 'package:todo_app/modules/app_color.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      required this.circleIcon,
      required this.circleButtonFunc,
      this.iconHeight,
      this.iconWidth,
      this.iconSize,
      this.backgroundColor,
      this.splashColor,
      this.iconColor})
      : super(key: key);

  final Color? backgroundColor;
  final Color? splashColor;
  final Color? iconColor;
  final double? iconHeight;
  final double? iconWidth;
  final double? iconSize;
  final IconData circleIcon;
  final Function() circleButtonFunc;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 3,
      color: backgroundColor ?? Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: splashColor ??
            AppColor.currentAppColor.withOpacity(0.2), // Splash color
        onTap: circleButtonFunc,
        child: SizedBox(
          width: iconWidth ?? 30,
          height: iconHeight ?? 30,
          child: Icon(
            circleIcon,
            color: iconColor ?? AppColor.currentAppColor.withAlpha(230),
            size: iconSize ?? 18,
          ),
        ),
      ),
    );
  }
}
