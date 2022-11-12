import 'package:account_book/models/AccountsModel.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'TransactionModel.dart';


class AccountTransactions {
  final String AccountId;
  final DateTime dateTime;
  final double Amount;
  final String Description;
  final String Type;
  final double PreviousBalance;
  


  AccountTransactions({
    required this.AccountId,
    required this.dateTime,
    required this.Amount,
    required this.Description,
    required this.Type,
    required this.PreviousBalance,

  });

  Map<String, dynamic> toJson() => {
    'AccountId': AccountId,
        'dateTime': dateTime,
        'Amount': Amount,
        'Description':Description,
        'Type': Type,

        'PreviousBalance': PreviousBalance,
      };

  static AccountTransactions fromJson(Map<String, dynamic> json) =>
      AccountTransactions(
        AccountId: json['AccountId'],
        dateTime: json['dateTime'],
        Amount: json['Amount'],
        Description:json['Description'],
        Type: json['Type'],
        PreviousBalance: json['PreviousBalance'],
      );
}


Future CreateTransaction(AccountsModel account, DateTime date, double TransAmount,
    String type, String Description) async {
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
      Description: Description,
      PreviousBalance: type == 'get'
          ? account.AccountBalance + TransAmount
          : type == 'give'
              //&& account.AccountBalance > TransAmount
              ? account.AccountBalance - TransAmount
              : account.AccountBalance);

  final json = AT.toJson();
  await AddTransaction.doc('$type | ${date.toString()}').set(json);
  
  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(account.AccountId)
      .update({'AccountBalance': AT.PreviousBalance.toDouble()});
}

