import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // إضافة مكتبة الأبعاد التكيفية
import 'package:news/main.dart';

import '../../../../core/widgets/custom_btn.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "All news in one place, be \n the first to know last news",
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall,
        ),

        SizedBox(height: 60.h),

        CustomBtn(isLoading: false, onPressed: onPressed, text: text),
      ],
    );
  }
}
