import 'package:account_book/models/TransactionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future AddNewAccount(String title, String phone, String type) async {
  final NewAccount = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc();

  final Acc = AccountsModel(
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
      .doc('created | ${DateTime.now()}' );

  final json1 = FirstTransaction.toJson();
  await TransactionLink.set(json1);



await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'TotalAccounts': FieldValue.increment(1)});
}

//  Method deleting account and all of it's 
//  transactions from firebase firestore.

Future<void> deleteAccount(String AcountID) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseFirestore trans = FirebaseFirestore.instance;

  var deleteTransactions = trans
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(AcountID)
      .collection('transactions');
  var snapshot = await deleteTransactions.get();
  for (var docs in snapshot.docs) {
    await docs.reference.delete();

  }

  db.collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(AcountID)
      .delete()
      .then(
        (doc) => print("Account Deleted"),
        onError: (e) => print("Error updating document $e"),
      );


      await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'TotalAccounts': FieldValue.increment(-1)});
}
