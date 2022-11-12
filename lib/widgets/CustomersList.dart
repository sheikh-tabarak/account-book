import 'package:account_book/models/TransactionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:account_book/Screens/Transactions/AccountTransactions.dart';
import 'package:account_book/models/AccountsModel.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import '../configurations/AppColors.dart';

class CustomerList extends StatelessWidget {
  final String image;
  final String CustomerName;
  final double balance;
  final Color color;
  late BuildContext globalcontext;
  late FirebaseFirestore db;

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
    //required this.db,
  }) : super(key: key);





  Stream<List<AccountsModel>> GetAccount() => FirebaseFirestore.instance
     // .collection('user').doc('o4yqvPnb7z5BCbV4a7DS').
      .collection('accounts').orderBy('AccountTitle',descending: false)
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((docs) => AccountsModel.fromJson(docs.data()))
          .toList());


    //        Stream<List<AccountTransactions>> GetAccount() => FirebaseFirestore.instance
    //  // .collection('user').doc('o4yqvPnb7z5BCbV4a7DS').
    //   .collection('transactions')
    //   .snapshots()
    //   .map((snapshots) => snapshots.docs
    //       .map((docs) => AccountTransactions.fromJson(docs.data()))
    //       .toList());


          

// void getStarted_readData() =>FirebaseFirestore.instance
//       .collection('accounts').get().then((value){
//       for (var doc in event.docs) {
//         print("${doc.id} => ${doc.data()}");
//       }});
      // .snapshots()
      // .map((snapshots) => snapshots.docs
      //     .map((docs) => AccountsC.fromJson(docs.data()))
      //     .toList());


  @override
  Widget build(BuildContext context) {
    setthecontext(context);

    return Container(

      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: StreamBuilder<List<AccountsModel>>(
            stream: GetAccount(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return 
                Text('No Relvant Data${snapshot.data}');
                
              } else if (snapshot.hasError) {
                return Text('Error');
              } else if (snapshot.hasData) {
                final accounts = snapshot.data!;

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: accounts.map(buildList).toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget buildList(AccountsModel account) => GestureDetector(
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
                                    // image: DecorationImage(
                                    //     image:
                                    //         NetworkImage(account.AccountImage),
                                    //     fit: BoxFit.cover)
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
