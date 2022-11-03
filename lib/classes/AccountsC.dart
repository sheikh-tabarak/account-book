import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:account_book/classes/DummyData.dart';

import 'AcountTransactions.dart';

class AccountsC {
   String AccountId;
  final String AccountImage;
  final String AccountTitle;
  final String AccountPhoneNo;
  final double AccountBalance;
  final String AccountType;
  late List Trans;
  //var AT;
  

  AccountsC({
    required this.AccountId,
    required this.AccountImage,
    required this.AccountTitle,
    required this.AccountPhoneNo,
    required this.AccountBalance,
    required this.AccountType,
  
  });
  Map<String, dynamic> toJson() => {
        'AccountId': AccountId,
        'AccountImage': AccountImage,
        'AccountTitle': AccountTitle,
        'AccountPhoneNo': AccountPhoneNo,
        'AccountBalance': AccountBalance,
        'AccountType': AccountType,
      };




  //     Map<String, dynamic> AddTransactionItem(String amount, String type){
  //   var amountDouble = double.parse(amount);
  //   if (type == "spent") {
  //     amountDouble = double.parse("-" + amount);
  //   }
  //   return {
  //     'transactions': FieldValue.arrayUnion([
  //       {
  //         "date": DateTime.now(),
  //         "amount": amountDouble,
  //       },
  //     ]),
  //     'AccountBalance': FieldValue.increment(amountDouble)
  //   };
  // }

  static AccountsC fromJson(Map<String, dynamic> json) => AccountsC(
    
      AccountId: json['AccountId'],
      AccountBalance: json['AccountBalance'],
      AccountImage: json['AccountImage'],
      AccountPhoneNo: json['AccountPhoneNo'],
      AccountTitle: json['AccountTitle'],
     AccountType: json['AccountType'], //A: json['A'], 

      );

  // AccountsC copyWith({
  //   String? AccountId,
  //   String? AccountImage,
  //   String? AccountTitle,
  //   String? AccountPhoneNo,
  //   double? AccountBalance,
  //   String? AccountType,
  // }) {
  //   return AccountsC(
  //     AccountId: AccountId ?? this.AccountId,
  //     AccountImage: AccountImage ?? this.AccountImage,
  //     AccountTitle: AccountTitle ?? this.AccountTitle,
  //     AccountPhoneNo: AccountPhoneNo ?? this.AccountPhoneNo,
  //     AccountBalance: AccountBalance ?? this.AccountBalance,
  //     AccountType: AccountType ?? this.AccountType,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};
  
  //   result.addAll({'AccountId': AccountId});
  //   result.addAll({'AccountImage': AccountImage});
  //   result.addAll({'AccountTitle': AccountTitle});
  //   result.addAll({'AccountPhoneNo': AccountPhoneNo});
  //   result.addAll({'AccountBalance': AccountBalance});
  //   result.addAll({'AccountType': AccountType});
  
  //   return result;
  // }

  // factory AccountsC.fromMap(Map<String, dynamic> map) {
  //   return AccountsC(
  //     AccountId: map['AccountId'] ?? '',
  //     AccountImage: map['AccountImage'] ?? '',
  //     AccountTitle: map['AccountTitle'] ?? '',
  //     AccountPhoneNo: map['AccountPhoneNo'] ?? '',
  //     AccountBalance: map['AccountBalance']?.toDouble() ?? 0.0,
  //     AccountType: map['AccountType'] ?? '',
  //   );
  // }

  // @override
  // String toString() {
  //   return 'AccountsC(AccountId: $AccountId, AccountImage: $AccountImage, AccountTitle: $AccountTitle, AccountPhoneNo: $AccountPhoneNo, AccountBalance: $AccountBalance, AccountType: $AccountType)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  
  //   return other is AccountsC &&
  //     other.AccountId == AccountId &&
  //     other.AccountImage == AccountImage &&
  //     other.AccountTitle == AccountTitle &&
  //     other.AccountPhoneNo == AccountPhoneNo &&
  //     other.AccountBalance == AccountBalance &&
  //     other.AccountType == AccountType ;
 
  // }

  // @override
  // int get hashCode {
  //   return AccountId.hashCode ^
  //     AccountImage.hashCode ^
  //     AccountTitle.hashCode ^
  //     AccountPhoneNo.hashCode ^
  //     AccountBalance.hashCode ^
  //     AccountType.hashCode ;
  
  // }

}
double TotalBalanceOverall() {
  double balance = 0;
  double positive = 0, negative = 0;

  for (var i = 0; i < AccountsData.length; i++) {
    if (AccountsData[i].AccountBalance < 0) {
      negative = negative + (-AccountsData[i].AccountBalance);
    } else if (AccountsData[i].AccountBalance >= 0) {
      positive = positive + AccountsData[i].AccountBalance;
    }
  }
  balance = positive - negative;
  return balance;
}

double PositiveBalance() {
  double positive = 0;

  for (var i = 0; i < AccountsData.length; i++) {
    if (AccountsData[i].AccountBalance >= 0) {
      positive = positive + AccountsData[i].AccountBalance;
    }
  }
  return positive;
}

double NegativeBalance() {
  double negative = 0;

  for (var i = 0; i < AccountsData.length; i++) {
    if (AccountsData[i].AccountBalance < 0) {
      negative = negative + (-AccountsData[i].AccountBalance);
    }
  }
  return negative;
}


//180