import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/AccountsC.dart';

Stream<List<AccountsC>> GetAccount() => FirebaseFirestore.instance
     // .collection('user').doc('o4yqvPnb7z5BCbV4a7DS').
      .collection('accounts/')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((docs) => AccountsC.fromJson(docs.data()))
          .toList());

          