import 'package:account_book/classes/AccountsC.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:account_book/classes/DummyData.dart';
import 'AcountTransactions.dart';


class AccountTransactions {
  final String AccountId;
  final DateTime dateTime;
  final double Amount;
  final String Type;
  final double PreviousBalance;


  AccountTransactions({
    required this.AccountId,
    required this.dateTime,
    required this.Amount,
    required this.Type,
    required this.PreviousBalance,
  });

  Map<String, dynamic> toJson() => {
    'AccountId': AccountId,
        'dateTime': dateTime,
        'Amount': Amount,
        'Type': Type,
        'PreviousBalance': PreviousBalance,
      };

  static AccountTransactions fromJson(Map<String, dynamic> json) =>
      AccountTransactions(
        AccountId: json['AccountId'],
        dateTime: json['dateTime'],
        Amount: json['Amount'],
        Type: json['Type'],
        PreviousBalance: json['PreviousBalance'],
      );
}
