import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todolist/viewmodel/create_task_viewmodel.dart';

import '../icons/create_task_icon_icons.dart';
import '../widgets/custome_textfield.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final FocusNode _focusOnTaskTitle = FocusNode();
  final FocusNode _focusTaskDetails = FocusNode();
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDetails = TextEditingController();

  @override
  void initState() {
    _focusOnTaskTitle.addListener(() {
      Provider.of<CreateTaskViewModel>(context, listen: false).changeTitleFocus(
          _focusOnTaskTitle.hasFocus, textEditingControllerTitle.text.length);
    });
    _focusTaskDetails.addListener(() {
      Provider.of<CreateTaskViewModel>(context, listen: false)
          .changeDetailsFocus(_focusTaskDetails.hasFocus,
              textEditingControllerDetails.text.length);
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusOnTaskTitle.removeListener(() {});
    _focusTaskDetails.removeListener(() {});
    _focusOnTaskTitle.dispose();
    _focusTaskDetails.dispose();
    textEditingControllerDetails.dispose();
    textEditingControllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Row(
                children: [
                  IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Provider.of<CreateTaskViewModel>(context, listen: false)
                            .finishPage(context);
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
                        Provider.of<CreateTaskViewModel>(context,listen: false).getFormattedDate(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16),
                child: Column(
                  children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<CreateTaskViewModel>(builder: (context, data, child) {
                    return CustomTextField(
                      textEditingController: textEditingControllerTitle,focusTask: _focusOnTaskTitle,focusOnTask: data.focusOnTaskTitle, label: 'Task Title',);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<CreateTaskViewModel>(builder: (context, data, child) {
                    return CustomTextField(
                      textEditingController: textEditingControllerDetails,focusTask: _focusTaskDetails,focusOnTask: data.focusOnTaskDetails, label: 'Task Details',);
                  }),
                ],),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0,bottom: 16),
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
                            onPressed: (){


                            }, child: const Text("Save")),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
