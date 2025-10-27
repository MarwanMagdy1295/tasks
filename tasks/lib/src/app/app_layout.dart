// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/pages/tasks/presentation/ui/tasks_screen.dart';

class AppLayout extends StatelessWidget {
  final String? passcode;
  const AppLayout({super.key, this.passcode});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      startLocale: Locale('en'), //Locale(di<PrefsService>().locale.get()),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          title: 'Tasks',
          theme: ThemeData(
            fontFamily: 'Cairo',
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.onDrag,
              thumbColor: AppColors.lightGreen,
            ),
            primaryColor: AppColors.white,
            radioTheme: RadioThemeData(
              fillColor: WidgetStateProperty.all(AppColors.black),
            ),
            scaffoldBackgroundColor: AppColors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.black,
              elevation: 0,
              titleTextStyle: AppTheme.titleSemiSmallMediumTextStyle,
              centerTitle: true,
              toolbarTextStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              foregroundColor: AppColors.white,
            ),
          ),
          home: const TasksScreen(),
        ),
      ),
    );
  }
}
