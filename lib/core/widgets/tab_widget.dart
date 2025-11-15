import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/theme/app_colors.dart';

class TabWidget extends StatelessWidget {
  final String label;

  final bool isSelected;

  const TabWidget({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: EdgeInsets.zero,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purplePrimary : AppColors.gray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white),
        ),
        child: Text(label),
      ),
    );
  }
}
