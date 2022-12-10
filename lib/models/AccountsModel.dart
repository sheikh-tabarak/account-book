import 'dart:io';
import 'package:path/path.dart' as Path;

import 'package:account_book/models/TransactionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';

class AccountsModel {
  String AccountId;
  final String AccountImage;
  final String AccountTitle;
  final String AccountPhoneNo;
  final double AccountBalance;
  final String AccountType;

  AccountsModel({
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

  static AccountsModel fromJson(Map<String, dynamic> json) => AccountsModel(
        AccountId: json['AccountId'],
        AccountBalance: json['AccountBalance'],
        AccountImage: json['AccountImage'],
        AccountPhoneNo: json['AccountPhoneNo'],
        AccountTitle: json['AccountTitle'],
        AccountType: json['AccountType'], //A: json['A'],
      );
}

//  Method Creating/adding a new account
//  as a document of account collection to
//  firebase firestore

Future AddNewAccount(
    String image, String title, String phone, String type) async {
  final NewAccount = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc();

  final Acc = AccountsModel(
    AccountId: NewAccount.id,
    AccountImage: image,
    AccountTitle: title,
    AccountPhoneNo: phone,
    AccountBalance: 0,
    AccountType: type,
  );
  final FirstTransaction = AccountTransactions(
      AccountId: Acc.AccountId,
      dateTime: DateTime.now(),
      Amount: 0,
      Type: '',
      Description: 'New Account Created',
      PreviousBalance: Acc.AccountBalance);

  final json = Acc.toJson();
  await NewAccount.set(json);

  final TransactionLink = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(Acc.AccountId)
      .collection('transactions')
      .doc('created | ${DateTime.now()}');

  final json1 = FirstTransaction.toJson();
  await TransactionLink.set(json1);

  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'TotalAccounts': FieldValue.increment(1)});
}

//  Method deleting account and all of it's
//  transactions from firebase firestore.

Future<void> deleteAccount(AccountsModel Account) async {
  
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseFirestore trans = FirebaseFirestore.instance;

  var deleteTransactions = trans
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(Account.AccountId)
      .collection('transactions');
  var snapshot = await deleteTransactions.get();
  for (var docs in snapshot.docs) {
    await docs.reference.delete();
  }

  db
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(Account.AccountId)
      .delete()
      .then(
        (doc) => print("Account Deleted"),
        onError: (e) => print("Error updating document $e"),
      );

  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'TotalAccounts': FieldValue.increment(-1)});

var fileUrl = Uri.decodeFull(Path.basename(Account.AccountImage)).replaceAll(new RegExp(r'(\?alt).*'), '');
final desertRef = firebase_storage.FirebaseStorage.instance.ref(fileUrl);
await desertRef.delete();

}




final firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<String> uploadAccountImage(
  String FileName,
  String FilePath,
) async {
  File file = File(FilePath);
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref('${FirebaseAuth.instance.currentUser!.email}/accounts/').child(FileName);
    await ref.putFile(File(FilePath));
    String imageUrl = await ref.getDownloadURL();
    print("Image URL : " + imageUrl);
    return imageUrl;
  } on firebase_core.FirebaseException catch (e) {
    print(e);
  }

  return '';
}

Future<String?> getImage(String imageName) async {
  if (imageName == null) {
    return null;
  }

  //   var urlRef= firebase_storage.FirebaseStorage.instance.ref().child(path)
  // else{

  // }
}
