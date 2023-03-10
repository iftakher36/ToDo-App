import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:todolist/utils/apptheme.dart';
import 'package:todolist/widgets/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final ToDoModel toDoModel;
  final int index;
  final Function checkFunction,navigateFunction;

  const CustomListTile({
    Key? key,
    required this.checkFunction,
    required this.index, required this.navigateFunction, required this.toDoModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SvgPicture.asset(toDoModel.isCompleted?"assets/checked.svg":"assets/uncheck.svg")
            InkWell(
              splashColor: Colors.black,
                onTap: (){
                  checkFunction(index);
                },
                child: Container(
                  height: 23,
                  width: 23,
                  margin: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey,width: 2)

                  ),
                  child: toDoModel.isCompleted?SvgPicture.asset("assets/checked.svg",width: 12,height: 12,fit: BoxFit.none,):Container(),
                )),
            const SizedBox(width: 10,),
            Expanded(
              child: InkWell(
                splashColor: Colors.black26,
                onTap: (){
                  navigateFunction(context,toDoModel);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText(text: toDoModel.taskTitle, fontWeight: FontWeight.w500, color: AppTheme.colorText, fontSize: 18),
                    CustomText(text: toDoModel.taskDetails
                        , fontWeight: FontWeight.w400, color: AppTheme.colorText, fontSize: 12),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
