import 'package:flutter/material.dart';

class FormInput2 extends StatelessWidget {
@required
  final String hintText;
  final double fontSize;
  final int maxLength;
  final int maxLines;
  final TextInputType keyboardType;
  final bool obsecureText;
  final Function validator;
  final bool autovalidate;
  final Function onSaved;
  final String initialValue;
  final TextEditingController controller;

  const FormInput2(
      {Key key,
        this.hintText,
        this.fontSize = 13,
        this.maxLength,
        this.maxLines = 1,
        this.validator,
        this.autovalidate = false,
        this.onSaved,
        this.keyboardType,
        this.obsecureText = false,
        this.initialValue,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.disabled, initialValue: initialValue,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: fontSize),
              maxLength: maxLength,
              maxLines: maxLines,
              obscureText: obsecureText,
              keyboardType: keyboardType,
              validator: validator,
              onSaved: onSaved,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[50]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[50]),
                  ),
                  labelStyle: TextStyle(color: Colors.grey[50]),
                  filled: false),
              textInputAction: TextInputAction.done,
            ),
          ),
      ),
    );
  }
}