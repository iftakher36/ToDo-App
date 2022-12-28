import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todolist/viewmodel/task_list_viewmodel.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

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
              const Text("DEC 27,2022",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  )),
              const Text("5 incomplete, 5 completed",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10,),
              const Divider(
                thickness: 1,
              ),
              Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              value: true,
                              onChanged: (status) {}),
                          title: const Text("Upload 1099 to Turbotax"),
                          subtitle:
                              const Text("In publishing and graphic design"),
                        );
                      }))
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
