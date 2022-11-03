import 'package:account_book/classes/AccountsC.dart';
import 'package:account_book/databases/DataStreams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../classes/AcountTransactions.dart';

int _count = 0;


Future AddNewAccount(String title, String phone, String type) async {
  final NewAccount = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc();

  final Acc = AccountsC(
    AccountId: NewAccount.id,
    AccountImage:
        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1666973637~exp=1666974237~hmac=85143508f2ec52e9df251ae1b03ef76ebef47326e6a9d433ea2df8a08feea754',
    AccountTitle: title,
    AccountPhoneNo: phone,
    AccountBalance: 0,
    AccountType: type,
  );

  final FirstTransaction = AccountTransactions(
      AccountId: Acc.AccountId,
      dateTime: DateTime.now(),
      Amount: 0,
      Type: 'New Account Created',
      PreviousBalance: Acc.AccountBalance);

  final json = Acc.toJson();
  await NewAccount.set(json);

  final TransactionLink = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(Acc.AccountId)
      .collection('transactions')
      .doc('0T');

  final json1 = FirstTransaction.toJson();
  await TransactionLink.set(json1);
}

int FindTotalNumberofTrans(AccountsC acount) {
  
  final FindCount = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(acount.AccountId)
      .collection('transactions')
      .get()
      .then((snapshot) => _count = snapshot.docs.length
   //  print(snapshot.docs.length.toString());
      );

// FindCount.get().then

  print(_count + 1);
  return _count + 1;
}

Future CreateTransaction(
    AccountsC account, DateTime date, double TransAmount, String type) async {
  final AddTransaction = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(account.AccountId)
      .collection('transactions');

  final AT = AccountTransactions(
      AccountId: account.AccountId,
      dateTime: date,
      Amount: TransAmount,
      Type: type,
      PreviousBalance: type == 'get'
          ? account.AccountBalance + TransAmount
          : type == 'give' && account.AccountBalance > TransAmount
              ? account.AccountBalance - TransAmount
              : account.AccountBalance);

  final json = AT.toJson();
  await AddTransaction.doc('${(FindTotalNumberofTrans(account)).toString()}T')
      .set(json);
  //count=FindTotalNumberofTrans();

  //  final NewAccount1 = FirebaseFirestore.instance.collection('accounts').doc(Acc.AccountId);
  //     await NewAccount1.update(IntialTransaction);
}
