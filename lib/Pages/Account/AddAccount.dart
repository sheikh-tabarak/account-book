import 'dart:async';

import 'package:account_book/HomePage.dart';
import 'package:account_book/Pages/Account/Accounts.dart';
import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/classes/AcountTransactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import '../../configurations/AppColors.dart';
import '../../configurations/Dimensions.dart';
import '../../databases/Functions.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final titleController = TextEditingController();
  final phoneNoController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Add Customer'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the title of Account',
                  ),
                ),
                TextField(
                  controller: phoneNoController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Phone no of Account',
                  ),
                ),
                TextField(
                  controller: typeController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the type of Account',
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
        child: 
        FloatingActionButton.extended(
          backgroundColor: AppColors.mainColor,
          onPressed: () => {
            AddNewAccount(titleController.text, phoneNoController.text, typeController.text),
          //  AddNewTransaction(),

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
                        SizedBox(width: Dimensions.width10,),
                        Text('Account Added Successfully'),
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
                  Text('Add Account'),
                ],
              )),
        ),

        
      ),
    );
  }

//   Future AddNewAccount() async {
//     final NewAccount = FirebaseFirestore.instance
//     .collection('user')
//     .doc(FirebaseAuth.instance.currentUser!.uid)
//     .collection('accounts')
//     .doc();

//     final Acc = AccountsC(
//         AccountId: NewAccount.id,
//         AccountImage:
//             'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1666973637~exp=1666974237~hmac=85143508f2ec52e9df251ae1b03ef76ebef47326e6a9d433ea2df8a08feea754',
//         AccountTitle: titleController.text,
//         AccountPhoneNo: phoneNoController.text,
//         AccountBalance: 100,
//         AccountType: typeController.text,

// );

//     final FirstTransaction = AccountTransactions(
//       AccountId:Acc.AccountId,
//         dateTime: DateTime.now(),
//         Amount: 0,
//         Type: 'created',
//         PreviousBalance: Acc.AccountBalance);


//     final json = Acc.toJson();
//     await NewAccount.set(json);

//      final TransactionLink = FirebaseFirestore.instance
//      .collection('user')
//      .doc('R6YEWRDHEsK0NrPTnhET')
//      .collection('accounts')
//     .doc(Acc.AccountId)
//     .collection('transactions')
//     .doc('0T');

//     final json1 = FirstTransaction.toJson();
//     await TransactionLink.set(json1);
//   }



  Future AddNewTransaction() async {

    final NewTransaction={
'AccountTransactions':FieldValue.arrayUnion([{
'date':DateTime.now(),
'description':'Account is Created',
'amount':0,
'type':'created'
}])};
        final NewAccount1 = FirebaseFirestore.instance.collection('user')
        
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('accounts')
        .doc();
        await NewAccount1.update(NewTransaction);
      //  TransactionItem()
}
}