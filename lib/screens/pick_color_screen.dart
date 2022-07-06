import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';

class PickColorScreen extends StatelessWidget {
  const PickColorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: AppColor.allPrimaryColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemBuilder: (_, int index) {
            return GridTile(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        stops: const [0.5, 0.5],
                        colors: [
                          Color(AppColor.allPrimaryColors[index]),
                          Colors.white
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
