import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../classes/AccountsC.dart';
import '../../classes/DummyData.dart';
import '../../configurations/AppColors.dart';
import '../../configurations/BigText.dart';
import '../../configurations/Dimensions.dart';
import '../../widgets/CustomersList.dart';
import '../../widgets/TableElement.dart';
import '../../widgets/highlightbox.dart';

class Cash extends StatelessWidget {
  const Cash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HighlightBox(
              size: Dimensions.height40*4,
              text: PositiveBalance().toString(),
              ArrowIcon: Icons.arrow_upward,
              message: 'Amount to give',
              textColor: Colors.green,
              color: AppColors.SucessColor,
            ),
            HighlightBox(
              size: Dimensions.height40*4,
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

// Container(
//    height:double.maxFinite,
//   child:
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            reverse: false,
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            // physics:AlwaysScrollableScrollPhysics(),

            //  physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              return  TableElement(
                      DateCell: DateTime.now(),
                      DescriptionCell: 'Sold my Phone',
                      TransactionUp: 2000,
                      TransactionDown: 0,
                      TransactionBalance: 100,);
            }),
//),

        // CustomerList(
        //     image:
        //         'https://raw.githubusercontent.com/jonataslaw/getx-community/master/getx.png',
        //     CustomerName: 'Muhammad Tabarak',
        //     balance: 100,
        //     color: Colors.green,
        //   ),
      ],
    );
  }
}
