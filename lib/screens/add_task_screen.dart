import 'package:flutter/material.dart';
import 'package:todo_app/modules/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    Key? key,
    this.text,
    required this.taskKey,
    required this.label,
    required this.buttonText,
    required this.afterTextValidationCallback,
  }) : super(key: key);

  final String? text;
  final dynamic taskKey;
  final void Function(String value, dynamic key) afterTextValidationCallback;
  final String label;
  final String buttonText;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _text = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obsecure = true;
  String? passedText;
  dynamic passedKey;

  @override
  void initState() {
    if (widget.text != null && widget.taskKey != null) {
      passedText = Provider.of<TaskData>(context, listen: false)
          .getTaskByKey(widget.taskKey)
          .name;
      passedKey = widget.taskKey;
      _text.value = TextEditingValue(
          text: passedText!,
          selection: TextSelection.collapsed(offset: passedText!.length));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var paddingbot = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: paddingbot),
        child: Container(
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      _submitTask();
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        setState(() {
                          _text.clear();
                        });
                        return 'فعالیت نمی تواند خالی باشد!';
                      }
                      return null;
                    },
                    controller: _text,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    cursorColor: AppColor.currentAppColor,
                    autofocus: true,
                    decoration: _inputDecoration(),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                TextButton(
                  child: Text(
                    widget.buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: _submitTask,
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
        ),
      ),
    );
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      widget.afterTextValidationCallback(_text.text.trim(), passedKey);
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
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
      labelText: widget.label,
      labelStyle: TextStyle(color: AppColor.currentAppColor),
      errorStyle: TextStyle(
        color: AppColor.currentAppColor,
      ),
    );
  }
}
