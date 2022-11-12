// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

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
    return Table(
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
                  text: TransactionDown == 0
                      ? ''
                      : TransactionDown.toString(),
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
    );
  }
}
