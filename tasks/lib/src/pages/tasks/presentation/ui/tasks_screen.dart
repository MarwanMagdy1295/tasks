import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks/src/app/di_service.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/assets/assets.gen.dart';
import 'package:tasks/src/core/utils/assets/translations/keys.dart';
import 'package:tasks/src/core/utils/components/delete_all_custom_dialog.dart';
import 'package:tasks/src/core/utils/components/custom_text_form_field.dart';
import 'package:tasks/src/core/utils/components/loading_widget.dart';
import 'package:tasks/src/core/utils/gaps.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/create_task/presentation/ui/create_task.dart';
import 'package:tasks/src/pages/tasks/presentation/components/task_card.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_cubit.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_state.dart';

int currentIndex = 0;

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<TasksScreenCubit>()..getTasks(),
      child: BlocConsumer<TasksScreenCubit, TasksScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<TasksScreenCubit>();
          return Scaffold(
            backgroundColor: AppColors.white,
            floatingActionButton: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton.small(
                onPressed: () async {
                  var taskCreated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTask(),
                      fullscreenDialog: true,
                    ),
                  );
                  if (taskCreated == true) {
                    //refresh screen
                    cubit.getTasks();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0.r),
                ),
                backgroundColor: AppColors.lightBlue,
                child: Skeleton.shade(
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: Text(
                            tasks_screen.tasks.tr(),
                            style: AppTheme.titleMediumLargeBoldTextStyle
                                .copyWith(color: AppColors.lightBlue),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              showDeleteAllTasksDialog(context, 'Delete Tasks');
                            },
                            child: Text(
                              tasks_screen.delete_all.tr(),
                              style: AppTheme.titleSemiSmallSemiboldTextStyle
                                  .copyWith(color: AppColors.appRed),
                            ),
                          ),
                        ),
                        AppGaps.hGap16,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...cubit.taskStatus.map(
                                (status) => Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.selectFilter(status);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: status.values.first == true
                                            ? AppColors.lightBlue
                                            : AppColors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          status.keys.first,
                                          style: AppTheme
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                color:
                                                    status.values.first == true
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppGaps.hGap20,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: customTextFeild(
                            controller: cubit.searchController,
                            isTitileAviable: false,
                            hint: tasks_screen.search.tr(),
                            hintStyle: AppTheme.bodyTextStyle,
                            contentStyle: AppTheme.bodyTextStyle,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.grey300,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.search, size: 22.0),
                            onChanged: (value) {
                              cubit.searchFilesByAnyChar();
                            },
                          ),
                        ),
                        cubit.tasks.isEmpty && state is TasksScreenSuccess
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.images.noTask.image(),
                                      AppGaps.hGap30,
                                      Text(
                                        'No tasks',
                                        style: AppTheme
                                            .semiSmallMediumBoldTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Skeletonizer(
                                  enabled: state is TasksScreenLoading,
                                  textBoneBorderRadius:
                                      TextBoneBorderRadius.fromHeightFactor(.5),
                                  justifyMultiLineText: true,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                    itemCount: state is TasksScreenLoading
                                        ? 6
                                        : cubit.tasks.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      bottom: 40,
                                    ),
                                    itemBuilder: (context, index) {
                                      return TaskCardComponent(
                                        task: state is TasksScreenLoading
                                            ? TaskModel(
                                                taskTitle: BoneMock.fullName,
                                                // createdAt: BoneMock.name,
                                                status: BoneMock.name,
                                              )
                                            : cubit.tasks[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                    if (state is TasksScreenDeleteTaskLoading)
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: AppColors.grey100.withValues(alpha: 0.4),
                        child: Center(child: LoadingWidget()),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
