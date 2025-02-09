import 'package:grem/Constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/textStyle.dart';

textFieldWithoutBorder({hintText,EdgeInsets? contentPadding,TextEditingController? controller}){
  return TextField(
    style: txtStyle14AndBlack,
    controller: controller,
    cursorColor: mainColor,
    decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding:contentPadding ?? EdgeInsets.zero,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: txtStyle14AndOther
    ),
  );
}


class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final int? maxLine;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; // Optional validation
  final ValueChanged<String>? onChanged; // Optional onChanged callback

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.maxLine = 1,
    this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.validator, // Nullable validation
    this.onChanged, // Nullable onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: txtStyle14AndBlack,
      cursorColor: mainColor,
      maxLines: maxLine,
      controller: controller,
      validator: validator, // Use provided validator, or null if not set
      onChanged: onChanged, // Use provided onChanged, or null if not set
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: txtStyle14AndOther,
        filled: true,
        fillColor: const Color(0xFFF7F7FC),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 11,
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator; // Validation support

  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.options,
    this.value,
    this.onChanged,
    this.validator, // Accepts a validator function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      hint: Text(hintText,style: txtStyle14AndOther,),
      validator: validator, // Apply validation
      style: txtStyle14AndBlack,
      decoration: InputDecoration(
        // hintText: hintText,
        // hintStyle: txtStyle14AndOther,
        filled: true,
        fillColor: const Color(0xFFF7F7FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 11,
        ),
      ),
      items: options.map((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role, style: txtStyle14AndBlack),
        );
      }).toList(),
    );
  }
}

