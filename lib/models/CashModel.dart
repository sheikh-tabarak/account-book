import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UserModel.dart';

class CashModel {
  final DateTime dateTime;
  final double TotalCash;
  final double Amount;
  final String Description;
  final bool type;

  CashModel({
    required this.dateTime,
    required this.TotalCash,
    required this.Amount,
    required this.Description,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'TotalCash': TotalCash,
        'Amount': Amount,
        'Description': Description,
        'type': type,
      };

  static CashModel fromJson(Map<String, dynamic> json) => CashModel(
        dateTime: json['dateTime'],
        TotalCash: json['TotalCash'],
        Amount: json['Amount'],
        Description: json['Description'],
        type: json['type'],
      );
}

Future AddNewCashTransaction(UserModel Current_User, DateTime date,
    double Amount, String Description, bool type) async {
  final AddorRemoveCash = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cash');

  // final StoretoUser = FirebaseFirestore.instance
  //     .collection('user')
  //     .doc(FirebaseAuth.instance.currentUser!.uid);

  final Cash = CashModel(
      dateTime: date,
      TotalCash: Current_User.Cash + Amount,
      Amount: Amount,
      Description: Description,
      type: type);
  final json = Cash.toJson();

  await AddorRemoveCash.doc(type == true ? 'Add | $Amount' : 'Remove | $Amount')
      .set(json);

  // StoretoUser.set({'Cash': Cash.TotalCash.toDouble()});

  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'Cash': type == true
        ? FieldValue.increment(Amount)
        : FieldValue.increment(-Amount)
  });
}
