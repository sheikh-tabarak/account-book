import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:flutter/material.dart';


class PaymentReciept extends StatelessWidget {
  const PaymentReciept({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
   crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.height15),
          decoration: BoxDecoration(

color: AppColors.mainColor,
borderRadius: BorderRadius.circular(10),

          ),
          
          width: 250,
          height:Dimensions.height40*2,
          child:      
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
SmallText(text: 'you got',color: Colors.white,),
 SizedBox(height: Dimensions.height5,),
 BigText(text:'Rs. 1000',color: Colors.white,) 
            ],
          )
           
          ,        ),

          SizedBox(height: Dimensions.height15,),
SmallText(text: '3:59 PM, 10 Dec, 2022'),

        SizedBox(height: Dimensions.height10,),

        SmallText(text: 'This is Custom Message of Transaction'),

        // SizedBox(height: Dimensions.height20,)
     ],
    );
  }
}