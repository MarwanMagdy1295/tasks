// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "general": {
    "app_name": "tasks",
    "some_thing_went_wrong": "حدث خطأ"
  },
  "tasks_screen": {
    "tasks": "Tasks",
    "delete": "Delete",
    "delete_all": "Delete all",
    "edit": "Edit",
    "all": "All",
    "new_task": "New",
    "pending": "Pending",
    "done": "Done",
    "donse": "Done"
  },
  "create_task": {
    "title": "Create task",
    "task_title": "Title",
    "task_title_validation": "Title required",
    "date": "Date",
    "task_status": "Status",
    "add": "Add"
  }
};
static const Map<String,dynamic> _ar = {
  "general": {
    "app_name": "tasks",
    "some_thing_went_wrong": "حدث خطأ"
  },
  "tasks_screen": {
    "tasks": "المهام",
    "delete": "حذف",
    "delete_all": "حذف الكل",
    "edit": "تعديل",
    "all": "الكل",
    "new_task": "جديد",
    "pending": "قيد التنفيذ",
    "done": "انتهت",
    "donse": "Done"
  },
  "create_task": {
    "title": "اضف مهمة",
    "task_title": "عنوان المهمة",
    "task_title_validation": "عنوان المهمة مطلوب",
    "date": "التاريخ",
    "task_status": "حالة المهمة",
    "add": "اضف"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "ar": _ar};
}
