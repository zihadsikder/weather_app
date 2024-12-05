import 'package:flutter/material.dart';

import '../../../../core/confiq/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';

class RowWidgets extends StatelessWidget {
  const RowWidgets({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTextStyle.normalTextStyle(
            fontSize: 14,
            color: AppColors.bgColor,
          ),
        ),
        Text(
          text2,
          style: AppTextStyle.normalTextStyle(
            fontSize: 14,
            color: AppColors.bgColor,
          ),
        ),
      ],
    );
  }
}
