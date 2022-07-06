import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _text = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obsecure = true;

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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    setState(() {
                      _text.clear();
                    });
                    return 'فعالیت جدید نمی تواند خالی باشد!';
                  }
                  return null;
                },
                controller: _text,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                cursorColor: AppColor.currentAppColor,
                autofocus: true,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.currentAppColor,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.currentAppColor,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.currentAppColor,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  labelText: 'فعالیت جدید',
                  labelStyle: TextStyle(color: AppColor.currentAppColor),
                  errorStyle: TextStyle(
                    color: AppColor.currentAppColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7.0,
            ),
            TextButton(
              child: const Text(
                'افزودن',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(_text.text.trim());
                  TaskData.refreshTasks();

                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.currentAppColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: AppColor.currentAppColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
