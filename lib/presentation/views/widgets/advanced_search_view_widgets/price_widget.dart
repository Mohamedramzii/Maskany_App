// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:maskany_app/presentation/views/widgets/advanced_search_view_widgets/custom_textfiled_forAdvSearch.dart';
import '../../../../core/app_resources/images.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key, required this.startController, required this.endController});

  final TextEditingController startController ;
  final TextEditingController endController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextFieldForAdvSearch(
                controller: startController, hinttext: 'من')),
        SizedBox(
          width: 30.w,
        ),
        SvgPicture.asset(Images.divider),
        SizedBox(
          width: 30.w,
        ),
        Expanded(
            child: CustomTextFieldForAdvSearch(
                controller: endController, hinttext: 'الي'))
      ],
    );
  }
}
