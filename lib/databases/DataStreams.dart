import 'package:account_book/classes/AccountsC.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Stream<QuerySnapshot<Map<String, dynamic>>> AllUsers() {
return FirebaseFirestore.instance
      .collection('user').snapshots();
}





Stream<QuerySnapshot<Map<String, dynamic>>> TransactionsOf(String account) {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(account)
      .collection('transactions')
      .snapshots();
}



Stream<QuerySnapshot<Map<String, dynamic>>> Accountforuser() {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .snapshots();
}




