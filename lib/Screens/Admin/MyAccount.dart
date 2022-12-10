import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:account_book/models/UserModel.dart';
import 'package:account_book/widgets/highlightbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAccount extends StatelessWidget {
  final UserModel user;
  const MyAccount({super.key, required this.user, });

  @override
  Widget build(BuildContext context) {

    return 
    
    Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [



    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error = ${snapshot.error}');

                              else if (snapshot.hasData) {
                                var output = snapshot.data!.data();
                                var cash =
                                    output!['Cash'];
                                    var passwords=output["password"];
                                    var username = output['username'];
                                    var phoneNumber = output['phoneNo'];
                                    var email=output['email'];
                                    var abalance=output['TotalAccounts'];
                                    var noofaccounts=output['TotalAccounts'];

                                    
                                     // <-- Your value

// String useremail=user.email;
// String username =user.username;
// double usercash = user.Cash;


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
            text:username.toString()),
          SizedBox(
            height: Dimensions.height10,
          ),
          SmallText(text:email.toString()),
          SizedBox(
            height: Dimensions.height20,
          ),
        //  HighlightBox(color:Color.fromARGB(255, 243, 243, 243), textColor:Colors.black,text: cash.toString(), message: "current cash", ArrowIcon: Icons.attach_money_outlined, size: 400)
ListTile(
  title: Text(email.toString()),
  iconColor: AppColors.mainColor,
  leading: Icon(Icons.email),
),

ListTile(
  title: Text(phoneNumber.toString()),
  iconColor: AppColors.mainColor,
  leading: Icon(Icons.call),
),

ListTile(
  title: Text("${noofaccounts.toString()} accounts"),
  iconColor: AppColors.mainColor,
  leading: Icon(Icons.account_circle),
),

ListTile(
  title: Text("Rs: ${cash.toString()} avalable in cash"),
  iconColor: AppColors.mainColor,
  leading: Icon(Icons.attach_money_outlined),
)


   
         
          //  Image.network('https://raw.githubusercontent.com/jonataslaw/getx-community/master/getx.png'),
        
  
        ])
        
        );
  }

  return Center(child: CircularProgressIndicator());

}

    )
      ]);

  }
}
