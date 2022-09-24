import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  required String? Function(String? ) validate,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  required String? label,
  required IconData prefix,
  void Function()? onTap,

  }) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix
    ),
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model) => Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['date']}'
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model['time']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    )
,);