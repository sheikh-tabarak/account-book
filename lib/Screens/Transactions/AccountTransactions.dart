//import 'dart:ffi';

import 'dart:async';
import 'dart:ffi';

import 'package:account_book/HomePage.dart';
import 'package:account_book/Screens/Transactions/AddTransaction.dart';
import 'package:account_book/models/TransactionModel.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:account_book/widgets/IconBox.dart';
import 'package:account_book/widgets/highlightbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart'; // for other locales
import '../../models/AccountsModel.dart';
import '../../configurations/AppColors.dart';
import '../../databases/DataStreams.dart';
import '../../databases/Functions.dart';
import '../../widgets/TableElement.dart';

class AccountDetailPage extends StatefulWidget {
  
  final AccountsModel account;

  AccountDetailPage({super.key, required this.account});

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  bool isLoading = false;

  double getBalance() {
    return widget.account.AccountBalance;
  }

  late AccountTransactions AT;

  late BuildContext globalcontext;

  void setthecontext(BuildContext context) {
    globalcontext = context;
  }

  BuildContext getthecontext() {
    return globalcontext;
  }

  Stream<List<AccountTransactions>> GetTrans() => FirebaseFirestore.instance
      .collection("transactions")
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((docs) => AccountTransactions.fromJson(docs.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('transactions');

    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      print('Data is here : $allData');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Row(
            //  mainAxisAlignment: MainAxisAlignment,

            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(widget.account.AccountImage),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: Dimensions.width15,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title(
                          color: Colors.white,
                          child: Text(
                              widget.account.AccountTitle.length >
                                      Dimensions.height10
                                  ? widget.account.AccountTitle
                                          .substring(0, 9) +
                                      '...'
                                  : widget.account.AccountTitle,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  )),
            ],
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.height10),
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Confirm deleting account"),
                              content: Text(
                                  "Would you like to delete ${widget.account.AccountTitle}"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    
                             deleteAccount(widget.account.AccountId);  
                              Navigator.pop(context);
                              Navigator.pop(context);
                    
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds:2),
                              backgroundColor: Colors.red,
                                content: Row(children: [
                              Icon(Icons.delete_sweep),
                              SizedBox(width: 10,),
                              Text('Account deleted'),
                            ])));
                                    
                                  },
                                  child: SmallText(
                                    text: 'Delete',
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete)

                  // icon:Icons.delete
                  ),
            ),
            Container(
              padding: EdgeInsets.only(left: Dimensions.height10),
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.edit)

                  // icon:Icons.delete
                  ),
            ),
          ]),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.mainBlackColor,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 80),
                      child: Column(
                        children: [
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('accounts')
                                .doc(widget.account.AccountId)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error = ${snapshot.error}');

                              else if (snapshot.hasData) {
                                var output = snapshot.data!.data();
                                var value =
                                    output!['AccountBalance']; // <-- Your value
                                return HighlightBox(
                                    size: Dimensions.height40 * 9,
                                    color: value >= 0
                                        ? AppColors.SucessColor
                                        : AppColors.DangerColor,
                                    textColor:
                                        value >= 0 ? Colors.green : Colors.red,
                                    text: value >= 0
                                        ? '$value'.toString()
                                        : '${(value * -1).toString()}',
                                    message: 'Current Balance',
                                    ArrowIcon: value >= 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward);
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconBox(
                                  BoxIcon: Icons.call,
                                  BoxText: 'Call Now',
                                  BoxWidth: Dimensions.width20 * 5.5,
                                  BoxLink:
                                      'tel:${widget.account.AccountPhoneNo}'),
                              IconBox(
                                  BoxIcon: Icons.mail,
                                  BoxText: 'Sent Email',
                                  BoxWidth: Dimensions.width20 * 5.5,
                                  BoxLink:
                                      'https://pub.dev/packages/url_launcher'),
                              IconBox(
                                  BoxIcon: Icons.whatsapp,
                                  BoxText: 'Whatsapp',
                                  BoxWidth: Dimensions.width20 * 5.5,
                                  BoxLink:
                                      'wa.me/:${widget.account.AccountPhoneNo}'),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
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
                                                padding: EdgeInsets.all(10),
                                                child: SmallText(
                                                  text: 'Date',
                                                  size: 12,
                                                ))),
                                        TableCell(
                                            //   verticalAlignment: TableCellVerticalAlignment.baseline,
                                            child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: 'I Gave',
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            //    verticalAlignment: TableCellVerticalAlignment.baseline,
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(
                                              text: 'I Got',
                                              size: 12,
                                            ),
                                          ],
                                        )),
                                      ])
                                    ]),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Container(
                                  child: StreamBuilder(
                                      stream: TransactionsOf(
                                          widget.account.AccountId),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.red,
                                              color: Colors.white,
                                            ),
                                            //   Text('No Relvant Data => ${snapshot.data} =>')
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('Error');
                                        } else {
                                          //     final transaction = snapshot.data;

                                          return Container(
                                            child: SingleChildScrollView(
                                              child: ListView(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: snapshot.data!.docs
                                                      .map((e) {
                                                    //  print(e['AccountTransactions'][0]['description']);
                                                    return TableElement(
                                                        DateCell:
                                                            //   e['AccountTransactions'].length,
                                                            //[0]['description'],
                                                            e['dateTime']
                                                                .toDate(),
                                                        DescriptionCell:
                                                            e['Description']
                                                                .toString(),
                                                        //    'Description',

                                                        //e['AccountTransactions'][0]['description'].toString(),
                                                        TransactionUp:
                                                            (e['Type'] == 'get')
                                                                ? (e['Amount'])
                                                                : (0.0),
                                                        TransactionDown:
                                                            (e['Type'] ==
                                                                    'give')
                                                                ? (e['Amount'])
                                                                : (0.0),
                                                        TransactionBalance: e[
                                                            'PreviousBalance']);
                                                  }).toList()),
                                            ),
                                          );
                                        }
                                        // else {
                                        //   return CircularProgressIndicator();
                                        // }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
              onPressed: () => {
                //  Navigator.pushNamed(context, '/page2').then((_) => setState(() {}));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTransaction(
                              account: widget.account,
                              type: 'give',
                            ))).then((value) => setState(
                      () => {},
                    )),
              },
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
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTransaction(
                                    account: widget.account,
                                    type: 'get',
                                  ))),
                    },
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

  Widget buildList(AccountTransactions trans) => GestureDetector(
        onTap: () => {
//
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
                Text(
                    '${trans.AccountId} Amount Boss-> ${trans.Amount} Type-> ${trans.Type}')
              ],
            )),
      );
}
