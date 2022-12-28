import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todolist/viewmodel/create_task_viewmodel.dart';

import '../icons/create_task_icon_icons.dart';
import '../viewmodel/task_list_viewmodel.dart';
import '../widgets/custome_textfield.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final FocusNode _focusNodeTaskTitle = FocusNode();
  final FocusNode _focusNodeTaskDetails = FocusNode();
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDetails = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateTaskViewModel>(context, listen: false)
          .getRouteData(context);
      _focusNodeTaskTitle.addListener(() {
        Provider.of<CreateTaskViewModel>(context, listen: false)
            .changeTitleFocus(_focusNodeTaskTitle.hasFocus,
                textEditingControllerTitle.text.length);
      });
      _focusNodeTaskDetails.addListener(() {
        Provider.of<CreateTaskViewModel>(context, listen: false)
            .changeDetailsFocus(_focusNodeTaskDetails.hasFocus,
                textEditingControllerDetails.text.length);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNodeTaskTitle.removeListener(() {});
    _focusNodeTaskDetails.removeListener(() {});
    _focusNodeTaskTitle.dispose();
    _focusNodeTaskDetails.dispose();
    textEditingControllerDetails.dispose();
    textEditingControllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CreateTaskViewModel>(context, listen: false).resetData();
        Provider.of<TaskListViewModel>(context, listen: false)
            .getCompleteAndIncompleteData();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Provider.of<CreateTaskViewModel>(context,
                                  listen: false)
                              .finishPageAndRefresh(context);
                        },
                        icon: const Icon(CreateTaskIcon.backbutton)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Create Task",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          Provider.of<CreateTaskViewModel>(context,
                                  listen: false)
                              .getFormattedDate(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<CreateTaskViewModel>(
                          builder: (context, data, child) {
                        return CustomTextField(
                          textEditingController: data.toDoModelRoute!=null?
                          (textEditingControllerTitle..text = data.toDoModelRoute!.taskTitle):textEditingControllerTitle,
                          focusTaskNode: _focusNodeTaskTitle,
                          focusOnTask: data.focusOnTaskTitle,
                          label: 'Task Title',
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<CreateTaskViewModel>(
                          builder: (context, data, child) {
                        return CustomTextField(
                          textEditingController:  data.toDoModelRoute!=null?(textEditingControllerDetails
                            ..text =data.toDoModelRoute!.taskDetails):textEditingControllerDetails,
                          focusTaskNode: _focusNodeTaskDetails,
                          focusOnTask: data.focusOnTaskDetails,
                          label: 'Task Details',
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 16),
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                              ),
                              onPressed: () {
                                Provider.of<CreateTaskViewModel>(context,
                                        listen: false)
                                    .insertAndUpdateTask(
                                        textEditingControllerTitle.text,
                                        textEditingControllerDetails.text,
                                        context);
                              },
                              child: Text(Provider.of<CreateTaskViewModel>(context,listen: true).toDoModelRoute!=null?"Update":"Save")),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
