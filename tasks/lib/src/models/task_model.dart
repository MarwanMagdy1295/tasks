import 'package:hive_ce_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? taskTitle;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? createdAt;

  TaskModel({this.id, this.taskTitle, this.status, this.createdAt});

  // factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
  //   id: json["id"],
  //   taskTitle: json["task_title"],
  //   status: json["status"],
  //   createdAt: json["created_at"],
  // );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "task_title": taskTitle,
  //   "status": status,
  //   "created_at": createdAt,
  // };
}
