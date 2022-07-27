import 'package:flutter/material.dart';
import 'package:todo_app/modules/app_color.dart';

class PickColorScreen extends StatelessWidget {
  const PickColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 0.7,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: AppColor.allPrimaryColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemBuilder: (_, int index) {
            return GridTile(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: AppColor.currentAppColor.withOpacity(0.6),
                      onTap: () {
                        Navigator.of(context).pop(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 0.5),
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            stops: const [0.5, 0.5],
                            colors: [
                              Colors.white,
                              Color(AppColor.allPrimaryColors[index]),
                            ],
                          ),
                        ),
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
