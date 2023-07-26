import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final title;
  final VoidCallback onPress;
  final Color color,textColor;
  final bool loading;
  const RoundButton({Key? key,
    required this.title,
    required this.onPress,
    required this.color,
     this.textColor=Colors.white,
    this.loading=false

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading?null:onPress,
      child: Container(
        height: 50,
        width: double.infinity,

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40)

        ),
        child:loading?Center(child: CircularProgressIndicator(color: Colors.white,)):Center(child: Text(title,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16,color: textColor),)) ,
      ),
    );
  }
}
