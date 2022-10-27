import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/widgets/CustomersList.dart';
import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/classes/DummyData.dart';
import 'package:flutter/material.dart';
import '../widgets/highlightbox.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            
            HighlightBox(
              text: PositiveBalance().toString(),
              ArrowIcon: Icons.arrow_upward,
              message: 'Amount to give',
              textColor: Colors.green,
              color: AppColors.SucessColor,
            ),
            HighlightBox(
              ArrowIcon: Icons.arrow_downward,
              message: 'Amount to get',
              textColor: Colors.red,
              text: NegativeBalance().toString(),
              color: AppColors.DangerColor,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height10, bottom: Dimensions.height10),
          padding: EdgeInsets.all(Dimensions.height5),
          height: 50,
          width: double.maxFinite,
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 260,
                height: 25,
                child: TextField(),
              ),
              Icon(Icons.search),
              Icon(Icons.picture_as_pdf),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: 'All accounts',
                  size: Dimensions.font15,
                ),
              ],
            ),
          ),
        ]),
        SizedBox(
          height: Dimensions.height10,
        ),
        
          CustomerList(
              image:
                  'https://raw.githubusercontent.com/jonataslaw/getx-community/master/getx.png',
              CustomerName: 'Muhammad Tabarak',
              balance: 100,
              color: Colors.green,
            ),
        
       
      ],
    );
  }
}
