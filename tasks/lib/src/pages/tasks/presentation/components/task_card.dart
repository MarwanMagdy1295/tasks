import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/components/delete_task_custom_dialog.dart';
import 'package:tasks/src/core/utils/gaps.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/create_task/presentation/ui/create_task.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_cubit.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_state.dart';

class TaskCardComponent extends StatelessWidget {
  final TaskModel task;
  const TaskCardComponent({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksScreenCubit, TasksScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            // leading: Checkbox(
            //   value: false,
            //   onChanged: (val) {},
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(4),
            //   ),
            // ),
            title: Text(
              task.taskTitle ?? '-',
              style: AppTheme.bodyLargeSemiboldTextStyle,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                task.createdAt != null
                    ? task.createdAt ?? ''
                    //  DateFormat.yMd().format(
                    //     DateTime.parse(task.createdAt ?? ''),
                    //   )
                    : '',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            trailing: PopupMenuButton(
              iconColor: AppColors.lightBlue,
              icon: const Icon(Icons.more_horiz),
              popUpAnimationStyle: AnimationStyle(),
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateTask(isEdit: true, task: task),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: AppColors.lightBlue,
                          size: 24.0,
                        ),
                        AppGaps.wGap8,
                        Text('edit', style: AppTheme.bodyTextStyle),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      showDeleteTaskDialog(
                        context,
                        'Delete Task (${task.taskTitle})',
                        task,
                      );
                    },
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        AppGaps.wGap8,
                        Text('delete', style: AppTheme.bodyTextStyle),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (value) {},
            ),
          ),
        );
      },
    );
  }
}
