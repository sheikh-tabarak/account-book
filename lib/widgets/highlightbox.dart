import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HighlightBox extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final String message;
  final IconData ArrowIcon;
  const HighlightBox({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.message,
    required this.ArrowIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
padding:EdgeInsets.all(Dimensions.height10),
      width:(Dimensions.height40*4),
      height: (Dimensions.height40*2),
      decoration: BoxDecoration(
         color: color,
        borderRadius: BorderRadius.circular(Dimensions.height10),
      ),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: Dimensions.height20,
                  height: Dimensions.height20,
                  decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(20)
                  ),      
          child:Icon(ArrowIcon, size: 20,color: Colors.white,),
                )
                
                                 ],
            ),
            SizedBox(width: Dimensions.height15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
BigText(text: 'Rs. $text',size: Dimensions.font20,color: textColor,),
SmallText(text: message, color: textColor,)
              ],
            )
          ],
        )

      ],)
      
    );
  }
}
