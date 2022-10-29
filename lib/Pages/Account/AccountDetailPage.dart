import 'package:account_book/HomePage.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:account_book/widgets/highlightbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // for other locales
import '../../classes/AccountsC.dart';
import '../../configurations/AppColors.dart';
import '../../widgets/TableElement.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountsC account;
  const AccountDetailPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: NetworkImage(account.AccountImage), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: Dimensions.width15,
          ),
          Title(color: Colors.white, child: Text(account.AccountTitle))
        ],
      )),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
        child: Column(
          children: [
            HighlightBox(
                size: Dimensions.height40 * 9,
                color: account.AccountBalance >= 0
                    ? AppColors.SucessColor
                    : AppColors.DangerColor,
                textColor:
                    account.AccountBalance >= 0 ? Colors.green : Colors.red,
                text: account.AccountBalance.toString(),
                message: 'Current Balance',
                ArrowIcon: Icons.arrow_upward),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Table(

                      //  TableCellVerticalAlignment.middle,
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(90),
                        2: FixedColumnWidth(90),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <TableCell>[
                          TableCell(
                              //   verticalAlignment: TableCellVerticalAlignment.bottom,
                              child: Container(
                                padding:EdgeInsets.all(10),
                                  child: SmallText(
                            text: 'Date',
                            size: 12,
                          ))),
                          TableCell(
                              //   verticalAlignment: TableCellVerticalAlignment.baseline,
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              padding:EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SmallText(
                                    text: 'Out',
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          )),
                          TableCell(
                              //    verticalAlignment: TableCellVerticalAlignment.baseline,
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SmallText(
                                text: 'In',
                                size: 12,
                              ),
                            ],
                          )),
                        ])
                      ]),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TableElement(
                      DateCell: DateTime.now(),
                      DescriptionCell: account.AccountType,
                      TransactionUp: 100,
                      TransactionDown: 0,
                      TransactionBalance: account.AccountBalance),
                  TableElement(
                      DateCell: DateTime.now(),
                      DescriptionCell: '',
                      TransactionUp: 0,
                      TransactionDown: 100,
                      TransactionBalance: account.AccountBalance)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          left: 35,
          right: 15,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () => {},
              label: Container(
                  width: Dimensions.height40 * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('I Gave'),
                      Icon(Icons.arrow_upward_outlined),
                    ],
                  )),
            ),
            FloatingActionButton.extended(
                backgroundColor: Colors.green,
                onPressed: () => {},
                label: Container(
                    width: Dimensions.height40 * 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('I Got'),
                        Icon(Icons.arrow_downward_outlined),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
