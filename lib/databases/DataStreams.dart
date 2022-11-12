import 'package:account_book/models/AccountsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Stream<QuerySnapshot<Map<String, dynamic>>> AllUsers() {
//   return FirebaseFirestore.instance.collection('user').snapshots();
// }

Stream<QuerySnapshot<Map<String, dynamic>>> TransactionsOf(String account) {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .doc(account)
      .collection('transactions')
      .orderBy('dateTime', descending: true)
      .snapshots();
}


Stream<QuerySnapshot<Map<String, dynamic>>> CashTransactionsOfCurrentUser() {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cash')
      .orderBy('dateTime', descending: true)
      .snapshots();
}




Stream<QuerySnapshot<Map<String, dynamic>>> Accountforuser() {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .snapshots();
}


Stream<QuerySnapshot<Map<String, dynamic>>> AllUsers() {
  return FirebaseFirestore.instance
      .collection('user')
      .snapshots();
}


// Get document with ID totalVisitors in collection dashboard
