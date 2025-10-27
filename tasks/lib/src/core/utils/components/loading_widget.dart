import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tasks/src/core/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: 80.w,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballScaleMultiple,
        colors: [AppColors.lightBlue],
        pathBackgroundColor: Colors.black,
      ),
    );
  }
}
