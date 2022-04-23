import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textView(text,
    {color = Colors.black,
    fontWeight = FontWeight.normal,
    fontSize = 16.0,
    textAlignment = TextAlign.left,
    alignment = Alignment.centerLeft}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),
    textAlign: textAlignment,
  );
}

Widget textField(
    {required title,
    required controller,
    required onChange,
    maxLines = 1,
    maxLen = 20,
    obscureText = false,
    isNumber = false,
    isEmail = false,
    isText = true,
    borderColor = Colors.black45,
    foucusBorderColor = Colors.black}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textView(title),
      const SizedBox(
        height: 6,
      ),
      TextField(
        controller: controller,
        onChanged: (value) {
          onChange(value);
        },
        maxLines: maxLines,
        maxLength: maxLen,
        obscureText: obscureText,
        keyboardType: isNumber
            ? TextInputType.number
            : isEmail
                ? TextInputType.emailAddress
                : TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(isNumber
              ? RegExp(r'[0-9]')
              : isEmail
                  ? RegExp("[a-zA-Z0-9.@_]")
                  : RegExp("[a-zA-Z0-9.@_-]")),
        ],
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: foucusBorderColor))),
      ),
    ],
  );
}
