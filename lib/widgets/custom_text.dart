import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  const CustomText({
    Key? key, required this.text, required this.fontWeight, required this.color, required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontWeight: fontWeight,color: color,fontSize: fontSize),);
  }
}
