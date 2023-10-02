import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_resources/colors.dart';
import '../app_resources/fonts.dart';

class CustomTextFormFieldWIdget extends StatelessWidget {
  const CustomTextFormFieldWIdget({
    Key? key,
    required this.hinttext,
    required this.controller,
    required this.isPassword,
    required this.isEmail,
    required this.textInputType,
    required this.textinputaction,
    required this.onsave,
    required this.onvalidate,
  }) : super(key: key);

  final String hinttext;
  final TextEditingController controller;
  final bool isPassword;

  final bool isEmail;
  final TextInputType textInputType;
  final TextInputAction textinputaction;
  final FormFieldSetter<String> onsave;
  final FormFieldValidator<String> onvalidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // scrollPadding: EdgeInsets.all(5.r),
      controller: controller,
      // style: TextStyle(),
      textDirection: isEmail ? TextDirection.ltr : TextDirection.rtl,
      onSaved: onsave,
      validator: onvalidate,
      obscureText: isPassword,
      keyboardType: textInputType,
      textInputAction: textinputaction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8.r),
        hintText: hinttext,
        hintStyle: Fonts.xsmall,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ))
            : null,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: ColorsManager.borderColor, width: 2)),
        enabledBorder: OutlineInputBorder(
            // gapPadding: 0,
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: ColorsManager.borderColor,
              width: 2,
              strokeAlign: 1,
            )),
        focusedBorder: OutlineInputBorder(
          // gapPadding: 0,
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: ColorsManager.borderColor,
            width: 2,
            strokeAlign: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          // gapPadding: 0,
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
            strokeAlign: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // gapPadding: 0,
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
            strokeAlign: 1,
          ),
        ),
      ),
    );
  }
}
