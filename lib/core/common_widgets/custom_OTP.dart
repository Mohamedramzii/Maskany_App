import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOTPWidget extends StatelessWidget {
  const CustomOTPWidget({
    Key? key,
    required this.onsave,
    required this.onvalidate,
    required this.pinController,
  }) : super(key: key);

  final TextEditingController pinController;
  final FormFieldSetter<String> onsave;
  final FormFieldValidator<String> onvalidate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68.h,
      width: 64.w,
      child: TextFormField(
        controller: pinController,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        onSaved: onsave,
        validator: onvalidate,
        decoration: InputDecoration(
            // hintText: '0',
            // hintStyle:
            //     Theme.of(context).textTheme.bodyLarge.copyWith(color: ColorsManager.kprimaryColor),
            ),
      ),
    );
  }
}
