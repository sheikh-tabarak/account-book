//import 'dart:ffi';

import 'package:account_book/HomePage.dart';
import 'package:account_book/Pages/Account/AddTransaction.dart';
import 'package:account_book/classes/AcountTransactions.dart';
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
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart'; // for other locales
import '../../classes/AccountsC.dart';
import '../../configurations/AppColors.dart';
import '../../databases/DataStreams.dart';
import '../../databases/Functions.dart';
import '../../widgets/TableElement.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountsC account;

  late AccountTransactions AT;

  late BuildContext globalcontext;

  void setthecontext(BuildContext context) {
    globalcontext = context;
  }

  BuildContext getthecontext() {
    return globalcontext;
  }

  AccountDetailPage({super.key, required this.account});

  Stream<List<AccountTransactions>> GetTrans() => FirebaseFirestore.instance
      .collection("transactions")
      //where('AccountId', isEqualTo: account.AccountId).docs()
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
                      image: NetworkImage(account.AccountImage),
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
                    Title(color: Colors.white, child: Text(account.AccountTitle)),
                  ],
                )),

             
                
               Container(
                padding: EdgeInsets.only(left: Dimensions.height10),
                alignment:Alignment.centerRight,
                  child: IconButton(
                    onPressed:(){
                      AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to delete ${account.AccountTitle}"),
    actions: [
   //   Navigate.pop()
      // ,
      // continueButton,
    ],
  );
FirebaseFirestore db = FirebaseFirestore.instance;
db.collection("user").doc(FirebaseAuth.instance.currentUser!.uid)..collection('accounts').doc(account.AccountId).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
                    },
                    icon:Icon(Icons.delete)
                               
                   // icon:Icons.delete
                   ),
                ),
             
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 80),
                child: Column(
                  children: [
                    HighlightBox(
                        size: Dimensions.height40 * 9,
                        color: account.AccountBalance >= 0
                            ? AppColors.SucessColor
                            : AppColors.DangerColor,
                        textColor: account.AccountBalance >= 0
                            ? Colors.green
                            : Colors.red,
                        text: account.AccountBalance.toString(),
                        message: 'Current Balance',
                        ArrowIcon: Icons.arrow_upward),
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
                            BoxLink: 'tel:${account.AccountPhoneNo}'),
                        IconBox(
                            BoxIcon: Icons.mail,
                            BoxText: 'Sent Email',
                            BoxWidth: Dimensions.width20 * 5.5,
                            BoxLink: 'https://pub.dev/packages/url_launcher'),
                        IconBox(
                            BoxIcon: Icons.whatsapp,
                            BoxText: 'Whatsapp',
                            BoxWidth: Dimensions.width20 * 5.5,
                            BoxLink: 'wa.me/:${account.AccountPhoneNo}'),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                stream: TransactionsOf(account.AccountId),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                        color: Colors.white,
                                      
                                      ),
                                      //   Text('No Relvant Data => ${snapshot.data} =>')
                                    );
                                  }
                                  else if (snapshot.hasError) {
                                    return Text('Error');
                                  } 
                                   else {
                                    //     final transaction = snapshot.data;

                                    return Container(
                                      child: SingleChildScrollView(
                                        child: ListView(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children:
                                                snapshot.data!.docs.map((e) {
                                                 //  print(e['AccountTransactions'][0]['description']);
                                              return TableElement(
                                                  DateCell:
                                               //   e['AccountTransactions'].length,
                                                  //[0]['description'],
                                                     e['dateTime'].toDate(),
                                                  DescriptionCell:
                                                    'Description',
                                                     
                                                      //e['AccountTransactions'][0]['description'].toString(),
                                                  TransactionUp:
                                                      (e['Type'] == 'get')
                                                          ? (e['Amount'])
                                                          : (0.0),
                                                  TransactionDown:
                                                      (e['Type'] == 'give')
                                                          ? (e['Amount'])
                                                          : (0.0),
                                                  TransactionBalance:
                                                      e['PreviousBalance']);
                                            }).toList()),
                                      ),
                                    );
                                  }
                                  // else {
                                  //   return CircularProgressIndicator();
                                  // }
                                }),
                          ),

                          // TableElement(
                          //     DateCell: DateTime.now(),
                          //     DescriptionCell: account.AccountType,
                          //     TransactionUp: 100,
                          //     TransactionDown: 0,
                          //     TransactionBalance: account.AccountBalance),
                          // TableElement(
                          //     DateCell: DateTime.now(),
                          //     DescriptionCell: '',
                          //     TransactionUp: 0,
                          //     TransactionDown: 100,
                          //     TransactionBalance: account.AccountBalance)
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTransaction(
                              account: account,
                              type: 'give',
                            ))),
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
                                    account: account,
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
