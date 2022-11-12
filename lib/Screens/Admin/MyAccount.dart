import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:account_book/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAccount extends StatelessWidget {

  //final UserModel user;


  const MyAccount({super.key, });

  @override
  Widget build(BuildContext context) {


String useremail=FirebaseAuth.instance.currentUser!.email.toString();
String username = useremail.substring(0,useremail.indexOf('@')).toUpperCase();



    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1666973637~exp=1666974237~hmac=85143508f2ec52e9df251ae1b03ef76ebef47326e6a9d433ea2df8a08feea754'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BigText(
            
            text:username),
          SizedBox(
            height: Dimensions.height10,
          ),
          SmallText(text:useremail),

          //  Image.network('https://raw.githubusercontent.com/jonataslaw/getx-community/master/getx.png'),
        ],
      ),
    );
  }
}
