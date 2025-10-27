// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/assets/translations/keys.dart';
import 'package:tasks/src/core/utils/components/custom_button.dart';
import 'package:tasks/src/core/utils/gaps.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_cubit.dart';

void showDeleteTaskDialog(
  BuildContext context,
  String? massege,
  TaskModel task,
) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: .5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppGaps.hGap20,
            Wrap(
              children: [
                Text(
                  massege ?? '',
                  textAlign: TextAlign.center,
                  style: AppTheme.semiSmallXBoldTextStyle,
                ),
              ],
            ),
            AppGaps.hGap40,
            SizedBox(
              width: MediaQuery.sizeOf(context).width.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: customButton(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<TasksScreenCubit>().deleteTask(task);
                      },
                      title: tasks_screen.yes.tr(),
                      titleStyle: AppTheme.bodyLargeSemiboldTextStyle.copyWith(
                        color: AppColors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      backgroundColor: AppColors.lightBlue,
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ),
                  AppGaps.wGap15,
                  Expanded(
                    child: customButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: tasks_screen.no.tr(),
                      titleStyle: AppTheme.bodyLargeSemiboldTextStyle.copyWith(
                        color: AppColors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      backgroundColor: AppColors.grey400,
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    },
  );
}
