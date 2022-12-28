import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todolist/utils/apptheme.dart';
import 'package:todolist/viewmodel/task_list_viewmodel.dart';

import '../widgets/custom_list_tile.dart';
import '../widgets/custom_text.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    Provider.of<TaskListViewModel>(context, listen: false)
        .getCompleteAndIncompleteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 30, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<TaskListViewModel>(builder: (context, data, child) {
                return Column(
                  children: [
                    Text(data.getFormattedDate(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        )),
                    Text(
                        "${data.incomplete.length} incomplete, ${data.complete.length} completed",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Consumer<TaskListViewModel>(
                            builder: (context, data, child) {
                          return Container(
                            child: index == 0
                                ? Provider.of<TaskListViewModel>(context,
                                            listen: false)
                                        .incomplete
                                        .isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: Provider.of<
                                                        TaskListViewModel>(
                                                    context,
                                                    listen: false)
                                                .incomplete
                                                .length +
                                            1,
                                        itemBuilder:
                                            (context, indexIncomplete) {
                                          return indexIncomplete == 0
                                              ? CustomText(
                                                  text: 'Incomplete',
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.colorText,
                                                  fontSize: 18,
                                                )
                                              : CustomListTile(
                                                  checkFunction: Provider.of<
                                                              TaskListViewModel>(
                                                          context,
                                                          listen: false)
                                                      .changeIncompleteTaskCheckBox,
                                                  index: indexIncomplete - 1,
                                                  navigateFunction: Provider.of<
                                                              TaskListViewModel>(
                                                          context,
                                                          listen: false)
                                                      .navigateToTaskCreatePageWithData,
                                                  toDoModel: data.incomplete[
                                                      indexIncomplete - 1],
                                                );
                                        })
                                    : Container()
                                : Provider.of<TaskListViewModel>(context,
                                            listen: false)
                                        .complete
                                        .isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            Provider.of<TaskListViewModel>(
                                                        context,
                                                        listen: false)
                                                    .complete
                                                    .length +
                                                1,
                                        itemBuilder: (context, indexComplete) {
                                          return indexComplete == 0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: CustomText(
                                                    text: 'Complete',
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.colorText,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              : CustomListTile(
                                                  checkFunction: Provider.of<
                                                              TaskListViewModel>(
                                                          context,
                                                          listen: false)
                                                      .changeCompleteTaskCheckBox,
                                                  index: indexComplete - 1,
                                                  navigateFunction: Provider.of<
                                                              TaskListViewModel>(
                                                          context,
                                                          listen: false)
                                                      .navigateToTaskCreatePageWithData,
                                                  toDoModel: data.complete[
                                                      indexComplete - 1],
                                                );
                                        })
                                    : Container(),
                          );
                        });
                      })),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset("assets/add.svg"),
        onPressed: () {
          Provider.of<TaskListViewModel>(context, listen: false)
              .navigateToTaskCreatePage(context);
        },
      ),
    );
  }
}
