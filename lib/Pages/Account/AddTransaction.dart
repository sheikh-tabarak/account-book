import 'dart:async';

import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/classes/AcountTransactions.dart';
import 'package:account_book/databases/Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../configurations/AppColors.dart';
import '../../configurations/Dimensions.dart';

class AddTransaction extends StatelessWidget {
  final AccountsC account;
  final String type;
  AddTransaction(
      {super.key, required this.type, required this.account});
//    final dateController = TextEditingController();
  final amountController = TextEditingController();
  final typeController = TextEditingController();
  final remainingBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: type == 'get'
            ? Text('I got !!')
            : type == 'give'
                ? Text('I gave !!')
                : Text('Error'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
              children: [
                TextField(
                  controller: amountController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Amount of Transaction',
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
        margin: EdgeInsets.only(
          left: 30,
          bottom: 0,
          right: 0,
        ),
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.mainColor,
          onPressed: () => {

            CreateTransaction(account, DateTime.now(), double.parse(amountController.text), type),
          //  CreateTransaction(account, DateTime.now(), double.parse(amountController.text), type),
           // AddNewTransaction(),
            //  AddNewTransaction(),
            // SnackBar(content: Text('Account Successfully Created')),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.green,
                  content: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_box,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Text('Transaction Successfully'),
                      ],
                    ),
                  )),
            ),
            Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
            }),
          },
          label: Container(
              width: Dimensions.height40 * 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  type == 'get' ? Text('Recieve') : Text('Give'),
                ],
              )),
        ),
      ),
    );
  }

  // Future AddNewTransaction() async {
  //   final NewAccount = FirebaseFirestore.instance
  //   .collection('user')
  //   .doc('R6YEWRDHEsK0NrPTnhET')
  //   .collection('accounts')
  //   .doc(account.AccountId)
  //       .collection('transactions')
  //       .doc();

  //   final AT = AccountTransactions(
  //     AccountId:account.AccountId,
  //       dateTime: DateTime.now(),
  //       Amount: double.parse(amountController.text),
  //       Type: type,
  //       PreviousBalance: type == 'get'
  //           ? account.AccountBalance +
  //               double.parse(amountController.text)
  //           : type=='give' && account.AccountBalance>double.parse(amountController.text)? account.AccountBalance -
  //               double.parse(amountController.text):account.AccountBalance);

  //   final json = AT.toJson();
  //   await NewAccount.set(json);

  //   //  final NewAccount1 = FirebaseFirestore.instance.collection('accounts').doc(Acc.AccountId);
  //   //     await NewAccount1.update(IntialTransaction);
  // }


//   Future AddNewTransaction() async {

//     final NewTransaction={
// 'AccountTransactions':FieldValue.arrayUnion([{
// 'date':DateTime.now(),
// 'amount':200,
// 'type':'spent'
// }])};
//         final NewAccount1 = FirebaseFirestore.instance.collection('accounts').doc('FJiQMXNlFARa1TCo8YTQ');
//         await NewAccount1.update(NewTransaction);
//       //  TransactionItem()
// }
}
