import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:account_book/Pages/Account/AccountDetailPage.dart';
import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';

import '../classes/DummyData.dart';

class CustomerList extends StatelessWidget {
  final String image;
  final String CustomerName;
  final double balance;
  final Color color;
  late BuildContext globalcontext;

  void setthecontext(BuildContext context) {
    globalcontext = context;
  }

  BuildContext getthecontext() {
    return globalcontext;
  }

  CustomerList({
    Key? key,
    required this.image,
    required this.CustomerName,
    required this.balance,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setthecontext(context);

    return Container(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: StreamBuilder<List<AccountsC>>(
            stream: GetAccount(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              } else if (snapshot.hasData) {
                final accounts = snapshot.data!;

                return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                          onTap: () => {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => AccountDetailPage(account:accounts.),
                                // )
                              },
                          child: Column(
                            children: accounts.map(buildList).toList(),
                          )),
                    ]);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Stream<List<AccountsC>> GetAccount() => FirebaseFirestore.instance
      .collection('accounts')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((docs) => AccountsC.fromJson(docs.data()))
          .toList());

  Widget buildList(AccountsC account) => GestureDetector(
        onTap: () => {
          Navigator.push(
              getthecontext(),
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
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: BigText(
                            text: account.AccountTitle,
                            size: Dimensions.font15,
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
