import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/app/app_layout.dart';
import 'package:tasks/src/app/di_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DiService.init();
  // await Hive.initFlutter();
  // Hive.registerAdapter(CustomerModelAdapter());
  // tasksBox = await Hive.openBox<TaskModel>('tasksBox');
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppLayout());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
