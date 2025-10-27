import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/app/di_service.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/assets/translations/keys.dart';
import 'package:tasks/src/core/utils/components/custom_button.dart';
import 'package:tasks/src/core/utils/components/custom_toast.dart';
import 'package:tasks/src/core/utils/components/filter_by_date.dart';
import 'package:tasks/src/core/utils/components/loading_widget.dart';
import 'package:tasks/src/core/utils/gaps.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/create_task/presentation/controller/cubit/create_task_screen_cubit.dart';
import 'package:tasks/src/core/utils/components/custom_text_form_field.dart';
import 'package:tasks/src/pages/create_task/presentation/controller/cubit/create_task_screen_state.dart';

class CreateTask extends StatelessWidget {
  final bool isEdit;
  final TaskModel? task;
  const CreateTask({super.key, this.isEdit = false, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Icon(Icons.close),
        ),
        title: Text('Ceate task'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocProvider(
          create: (context) =>
              di<CreateTaskScreenCubit>()..setData(task ?? TaskModel()),
          child: BlocConsumer<CreateTaskScreenCubit, CreateTaskScreenState>(
            listener: (context, state) {
              if (state is CreateTaskScreenFailedState) {
                customToast(state.errorMessage);
              } else if (state is CreateTaskScreenSuccessState) {
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              final cubit = context.read<CreateTaskScreenCubit>();
              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap24,
                          customTextFeild(
                            controller: cubit.titleController,
                            title: create_task.task_title.tr(),
                            isTitileAviable: true,
                            titleStyle: AppTheme.bodySemiboldTextStyle,
                            hint: create_task.task_title.tr(),
                            hintStyle: AppTheme.bodyTextStyle,
                            contentStyle: AppTheme.bodyTextStyle,
                            keyboardType: TextInputType.text,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 14.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.grey300,
                              ),
                            ),
                            isFill: true,
                            color: AppColors.white,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return create_task.task_title_validation.tr();
                              }
                              return null;
                            },
                          ),
                          AppGaps.hGap16,
                          GestureDetector(
                            onTap: () {
                              SelectDate.selectDate(context, cubit);
                            },
                            child: customTextFeild(
                              controller: cubit.dateController,
                              title: create_task.date.tr(),
                              isTitileAviable: true,
                              editable: false,
                              titleStyle: AppTheme.bodySemiboldTextStyle,
                              hint: create_task.date.tr(),
                              hintStyle: AppTheme.bodySemiboldTextStyle,
                              contentStyle: AppTheme.bodyLargeSemiboldTextStyle,
                              keyboardType: TextInputType.text,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: AppColors.grey300,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: AppColors.red,
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.grey500,
                              ),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return add_new_report_screen.date_error.tr();
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          if (isEdit)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppGaps.hGap16,
                                Text(
                                  create_task.task_status.tr(),
                                  style: AppTheme.bodySemiboldTextStyle,
                                ),
                                AppGaps.hGap10,
                                DropdownSearch<String>(
                                  selectedItem: cubit.selectedState,
                                  clearButtonProps: const ClearButtonProps(
                                    isVisible: false,
                                  ),
                                  items: [
                                    tasks_screen.pending.tr(),
                                    tasks_screen.done.tr(),
                                  ],
                                  dropdownButtonProps:
                                      const DropdownButtonProps(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.grey500,
                                        ),
                                      ),
                                  popupProps: PopupProps.menu(
                                    menuProps: MenuProps(
                                      backgroundColor: AppColors.grey25,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    constraints: BoxConstraints(
                                      maxHeight: 200.0,
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                  ),
                                              hintText: create_task.task_status
                                                  .tr(),
                                              hintStyle:
                                                  AppTheme.bodyLargeTextStyle,
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: AppColors.grey300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffD0D5DD),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4.0,
                                                        ),
                                                    borderSide:
                                                        const BorderSide(
                                                          color: Color(
                                                            0xffD0D5DD,
                                                          ),
                                                        ),
                                                  ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffD0D5DD),
                                                ),
                                              ),
                                            ),
                                      ),
                                  onChanged: (value) {
                                    cubit.selectedState =
                                        value == tasks_screen.pending.tr()
                                        ? 'pending'
                                        : 'done';
                                  },
                                ),
                              ],
                            ),
                          AppGaps.hGap40,
                          customButton(
                            onTap: () {
                              cubit.addOrEditNewTask(
                                isEdit,
                                task ?? TaskModel(),
                              );
                            },
                            title: create_task.add.tr(),
                            titleStyle: AppTheme.bodyLargeSemiboldTextStyle
                                .copyWith(color: AppColors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: AppColors.lightBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is CreateTaskScreenLoadingState)
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      color: AppColors.grey25.withValues(alpha: .2),
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * .16,
                          width: double.maxFinite,
                          child: const LoadingWidget(),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
