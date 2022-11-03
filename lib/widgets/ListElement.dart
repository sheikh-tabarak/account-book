import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:flutter/material.dart';

import '../Pages/Account/AccountDetailPage.dart';

class ListElement extends StatelessWidget {
  final AccountsC account;
  const ListElement({super.key, required this.account});
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountDetailPage(account: account))),
        },
        child: Container(
          padding: EdgeInsets.only(
              top: Dimensions.height20, bottom: Dimensions.height20),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Color.fromARGB(255, 197, 197, 197)))),
          child: Column(
            children: [
              Container(
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(64),
                    1: FlexColumnWidth(),
                    2: IntrinsicColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(account.AccountImage),
                                        fit: BoxFit.cover)
                                        ),
                              ),
                            ],
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: account.AccountTitle,
                              //   text: account.AccountId,
                                size: Dimensions.font15,
                              ),
                              SizedBox(height: Dimensions.height10,),
                              Container(
                                width: Dimensions.width30*3,
                                  decoration: BoxDecoration(
                                      color: AppColors.SucessColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.all(7),
                                  child: Row(
                                    children: [

                                  //    Icon(Icons.delivery_dining),
                                   account.AccountType == 'Supplier'?
                                    //   account.Type == 'get'?
                                        Icon(Icons.delivery_dining,  color: Colors.grey,
                                        size: 12,):
                                     //   account.Type=='give'
                                       account.AccountType ==
                                           'Customer'
                                          ?
                                        Icon(Icons.sell,  color: Colors.grey,
                                        size: 12,):
                                      Icon(Icons.account_box,  color: Colors.grey,
                                        size: 12,),
                                      SizedBox(width: Dimensions.width5,),
                                      BigText(
                                         text: account.AccountType,
                                    //    text: account.PreviousBalance.toString(),
                                        color: Colors.grey,
                                        size: 12,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        TableCell(
                          child: SmallText(
                            text: 'Rs. ${account.AccountBalance}',
                            color: account.AccountBalance >= 0
                                ? Colors.green
                                : Colors.red,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}