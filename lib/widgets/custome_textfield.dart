import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/utils/apptheme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
        required this.textEditingController,
        required FocusNode focusTaskNode,
        required bool focusOnTask,
        required String label})
      : _focusTaskNode = focusTaskNode,
        _focusOnTask = focusOnTask,
        _label = label,
        super(key: key);

  final TextEditingController textEditingController;
  final FocusNode _focusTaskNode;
  final bool _focusOnTask;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      focusNode: _focusTaskNode,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
        ),
        contentPadding: EdgeInsets.zero,
        label: Container(
          color: _focusOnTask ? AppTheme.lightPrimaryColor : null,
          child: Padding(
            padding:
            const EdgeInsets.only(top: 4.0, bottom: 4, left: 8, right: 8),
            child: Text(
              _label,
              style:
              TextStyle(color: _focusOnTask ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}