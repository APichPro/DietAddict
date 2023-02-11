import 'package:diet_junkie/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  void Function(String)? onchanged;
  TextEditingController controller;
  Icon? prefixIcon;
  String? prefixText;
  bool? num;

  CustomTextField({
    this.onchanged,
    required this.controller,
    this.prefixIcon,
    this.prefixText,
    this.num,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          color: yellow50,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        cursorColor: white,
        style: whiteTextStyle(20),
        onChanged: onchanged,
        keyboardType: num == true ? TextInputType.number : null,
        inputFormatters:
            num == true ? [FilteringTextInputFormatter.digitsOnly] : null,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? null,
          prefixText: prefixText ?? null,
          prefixStyle: whiteTextStyle(20),
        ),
      ),
    );
  }
}
