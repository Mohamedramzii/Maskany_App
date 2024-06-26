// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import '../app_resources/colors.dart';

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
    required this.onvalidate, required this.obsecure,
  }) : super(key: key);

  final String hinttext;
  final TextEditingController controller;
  final bool isPassword;
  final bool obsecure;
// final Widget prefixIcon;
  final bool isEmail;
  final TextInputType textInputType;
  final TextInputAction textinputaction;
  final FormFieldSetter<String> onsave;
  final FormFieldValidator<String> onvalidate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // scrollPadding: EdgeInsets.all(5.r),
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15.sp),
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
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: obsecure
                ? IconButton(
                    onPressed: () {
                      cubit.toggleVisibility();
                    },
                    icon: Icon(
                      cubit.isvisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ))
                : null,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    BorderSide(color: ColorsManager.borderColor, width: 2)),
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
      },
    );
  }
}
