import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.controller,
    this.prefix,
    this.suffix,
    this.enabled,
    this.hintText,
    this.disabledBorder,
    this.enabledBorder,
    this.textStyle,
    this.border,
    this.focusColor,
    this.focusBorder,
    this.fillColor,
    this.focusNode,
    this.keyboardType,
    this.onChange,
  });

  TextEditingController? controller;
  Widget? prefix;
  Widget? suffix;
  bool? enabled;
  String? hintText;
  InputBorder? disabledBorder;
  InputBorder? enabledBorder;
  TextStyle? textStyle;
  InputBorder? border;
  Color? focusColor;
  InputBorder? focusBorder;
  Color? fillColor;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      style: textStyle,
      keyboardType: keyboardType ,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        focusColor: focusColor,
        focusedBorder: focusBorder,
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hintText,
          border: border,
          enabled: enabled ?? false,
          disabledBorder: disabledBorder),
      enabled: enabled ?? false,
    );
  }
}
