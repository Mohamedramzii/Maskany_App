import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../app_resources/images.dart';
import 'custom_buttom.dart';

abstract class Dialogs {
  static successDialog(
    context,
    String text,
    Function() onpressed
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          backgroundColor: Colors.white,
          title: Center(
            child: Image.asset(Images.successLogo),
          ),
          content: Container(
            alignment: Alignment.center,
            height: 200.h,
            width: 400.w,
            child: Column(
              children: [
                Text(
                  S.of(context).ChangedPasswordSuccess,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  S.of(context).ChangedPasswordSuccess2,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Spacer(),
                CustomButton(text: text, onpressed: () {
                  onpressed;
                })
              ],
            ),
          ),
        ),
      );

  static failureDialog(
    context,
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          backgroundColor: Colors.white,
          title: const Center(
            child: Icon(
              Icons.info_outline,
              color: Colors.red,
            ),
          ),
          content: Container(
            alignment: Alignment.center,
            height: 200.h,
            width: 400.w,
            child: Column(
              children: [
                Text(
                  'Location Access',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Please check your location settings',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Spacer(),
                CustomButton(
                    text: 'ابدأ الان',
                    onpressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      );
}
