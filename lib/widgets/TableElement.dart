// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:account_book/widgets/PaymentReciept.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../configurations/AppColors.dart';
import '../configurations/BigText.dart';
import '../configurations/Dimensions.dart';
import '../configurations/SmallText.dart';

class TableElement extends StatelessWidget {
  final DateTime DateCell;
  final DateFormat Dateformat = DateFormat('dd MMM,').add_jm();
  final String DescriptionCell;
  final double TransactionUp;
  final double TransactionDown;
  final double TransactionBalance;

  TableElement(
      {super.key,
      required this.DateCell,
      required this.DescriptionCell,
      required this.TransactionUp,
      required this.TransactionDown,
      required this.TransactionBalance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {

      //  showBottomSheet(context: context, builder: builder)

showDialog(context: context, builder:(context)=> AlertDialog(

  title: Text("Payment Reciept"),
  content: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.height15),
          decoration: BoxDecoration(

color: TransactionUp==0?Colors.red:Colors.green,
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
SmallText(text:TransactionUp==0?'You give':"You got",color: Colors.white,),
 SizedBox(height: Dimensions.height5,),
 BigText(text:'Rs. ${TransactionUp==0?TransactionDown:TransactionUp}',color: Colors.white,) 
            ],
          )
           
          ,        ),

          SizedBox(height: Dimensions.height15,),
SmallText(text: "${DateFormat.yMEd().add_jms().format(DateCell)} "),

        SizedBox(height: Dimensions.height10,),

        SmallText(text: DescriptionCell),

        // SizedBox(height: Dimensions.height20,)
     ],
    ),
  actions: [
TextButton(onPressed: (){
Navigator.pop(context);
}, 
child: Text('Close'))
  ],

)),

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('You Clicked on single transaction !!'),
        //   duration: const Duration(seconds: 1),
        //   backgroundColor: Colors.red,
        // ))
      },
      child: Table(
        //  TableCellVerticalAlignment.middle,

        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FixedColumnWidth(90),
          2: FixedColumnWidth(90),
        },

        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromARGB(255, 213, 213, 213), width: 0.4),
              ),
            ),
            children: <Widget>[
              TableCell(
                //  crossAxisAlignment: MainAxisAlignment.start,
                verticalAlignment: TableCellVerticalAlignment.middle,
                //   crossAxisAlignment:Tablecell
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 213, 213, 213),
                            width: 0.4),
                      )),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(Dimensions.height15),
                  //   height: 50,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: Dateformat.format(DateCell).toString(),
                        size: 16,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      SmallText(
                        text: DescriptionCell,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: AppColors.SucessColor,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(Dimensions.height5),
                          child: BigText(
                            text: 'Bal. Rs $TransactionBalance',
                            color: Colors.grey,
                            size: 10,
                          ))
                    ],
                  ),
                ),
              ),

              //constraints: BoxConstraints.expand(),

              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 244, 244, 244),
                  ),
                  padding: EdgeInsets.all(Dimensions.height15),
                  margin: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  //  height: double.,
                  //    height: double.,

                  child: SmallText(
                    text:
                        TransactionDown == 0 ? '' : TransactionDown.toString(),
                    color: Colors.red,
                    weight: FontWeight.w600,
                  ),
                ),
              ),

              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(Dimensions.height15),
                  margin: EdgeInsets.zero,

                  //  height: 97,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SmallText(
                    text: TransactionUp == 0 ? '' : TransactionUp.toString(),
                    color: Colors.green,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
