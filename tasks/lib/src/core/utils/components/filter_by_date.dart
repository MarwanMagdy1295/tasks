// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:intl/intl.dart' as intl;

class SelectDate {
  static Future<bool> selectDate(
    BuildContext context,
    dynamic controller,
  ) async {
    DateTime? iOSDate;
    bool dateChoosed = false;
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .4,
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E4897),
                    ),
                  ),
                  onPressed: () {
                    if (iOSDate != null) {
                      controller.dateController.text = intl.DateFormat(
                        'd-M-y',
                      ).format(iOSDate);
                      controller.date = intl.DateFormat(
                        'd-M-y',
                      ).format(iOSDate);
                    }
                    Navigator.of(context).pop();
                  },
                ),
                Flexible(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumDate:
                        DateTime.now(), //DateTime.now().add(Duration(days: 1)),
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // firstDate: DateTime.now().subtract(Duration(days: 30000)),
        // lastDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 90)),
        lastDate: DateTime.now().add(Duration(days: 90)),
        //DateTime.now(),
        //DateTime.now().add(Duration( days: 200)),
        // //DateTime.now().subtract(const Duration(days: 2100)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColors.lightBlue,
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
              colorScheme: const ColorScheme.light(
                primary: AppColors.lightBlue,
              ).copyWith(secondary: AppColors.lightBlue),
            ),
            child: child!,
          );
        },
      );
      // print('${date}');
      if (date != null) {
        // controller.dateController.text = intl.DateFormat.yMd(
        //   'ar_SA',
        // ).format(date);
        controller.dateController.text = intl.DateFormat.yMd('en').format(date);
        controller.date = intl.DateFormat('y-M-d').format(date);
        dateChoosed = true;
      }
    }
    return dateChoosed;
  }
}
