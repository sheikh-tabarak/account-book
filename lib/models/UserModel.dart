import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
//  final String UserImage;
    final String username;
    final String password;
    final String email;
    final String phoneNo;
    final double Cash;
    final String role;
    final int TotalAccounts;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.Cash,
    required this.TotalAccounts,
    required this.role,
  });

  // factory UserModel.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return UserModel(
  //     username: data?['username'],
  //     email: data?['email'],
  //     password: data?['password'],
  //     phoneNo: data?['phoneNo'],
  //     TotalAccounts: data?['TotalAccounts'],
  //     role: data?["role"],
  //     Cash: data?["Cash"]
  //     //    data?['role'] is Iterable ? List.from(data?['role']) : null,
  //   );
  // }


  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'username': username,
  //       'email': email,
  //       'role': role,
  //       'password': password,
  //       'phoneNo': phoneNo,
  //       'Cash': Cash,
  //       'TotalAccounts': TotalAccounts,
  //       'role': role,
  //   };
  // }


   Map<String, dynamic> toJson() => {
     'username': username,
        'email': email,
        'role': role,
        'password': password,
        'phoneNo': phoneNo,
        'Cash': Cash,
        'TotalAccounts': TotalAccounts,
        'role': role,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'],
         email: json['email'],
        password: json['password'],
        phoneNo: json['phoneNo'],
        Cash: json['Cash'],
        TotalAccounts: json['TotalAccounts'],
        role: json['role'],
      );
}


Future RegisterNewUser(
    String username, String Password, String PhoneNo,String Email) async {
  final Register = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final NewUser = UserModel(
      Cash: 0,
      phoneNo: PhoneNo,
      username: username,
      email: Email,
      password: Password,
      TotalAccounts: 0,
      role: 'user'
      );

  final json = NewUser.toJson();
  await Register.set(json);
}



