import 'package:account_book/Screens/loading.dart';
import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/models/AccountsModel.dart';
import 'package:account_book/widgets/Empty.dart';
import 'package:account_book/widgets/ListElement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../databases/DataStreams.dart';
import '../../widgets/highlightbox.dart';

class Accounts extends StatefulWidget {
  Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Accountforuser(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          double NegativeBalance = 0;
          double positiveBalance = 0;
          if (!snapshot.hasData) {
            return Center(child: Empty());
          }

        //  else if (){}
           else if (snapshot.hasError) {
            return Text('Error');
          } else if(snapshot.hasData){
            return Column(children: [
              Row(
                  children: snapshot.data!.docs.map((e) {
                if (e['AccountBalance'] >= 0) {
                  positiveBalance = positiveBalance + e['AccountBalance'];
                } else {
                  NegativeBalance =
                      NegativeBalance + (-1 * (e['AccountBalance']));
                }
                return Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.red),
                  width: 0,
                  height: 0,
                  child: Text(''),
                );
              }).toList(growable: false)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HighlightBox(
                    size: Dimensions.height40 * 4,
                    text: positiveBalance.toString(),
                    //TotalBalance().toString(),
                    //TotalBalance();
                    //  sendPositive().toString(),
                    ArrowIcon: Icons.arrow_upward,
                    message: 'Amount to give',
                    textColor: Colors.green,
                    color: AppColors.SucessColor,
                  ),
                  HighlightBox(
                    size: Dimensions.height40 * 4,
                    ArrowIcon: Icons.arrow_downward,
                    message: 'Amount to get',
                    textColor: Colors.red,
                    text: NegativeBalance.toString(),
                    color: AppColors.DangerColor,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                padding: EdgeInsets.all(Dimensions.height5),
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 260,
                      height: 25,
                      child: TextField(),
                    ),
                    Icon(Icons.search),
                    Icon(Icons.picture_as_pdf),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  child: Column(
                    children: [
                      BigText(
                        text: 'All accounts',
                        size: Dimensions.font15,
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: Dimensions.height10,
              ),
              SizedBox(
                height: Dimensions.screenHeight - 50,
                child: SingleChildScrollView(
                  child: ListView(
                      shrinkWrap: true,
                      //      physics: const NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((e) {
                        int s=0;
                        // if (s==0) {
                        //   return Empty();
                        // }
                       //  else {
                          positiveBalance =
                              positiveBalance + e['AccountBalance'];
                          return ListElement(
                              account: AccountsModel(
                                  AccountId: e['AccountId'],
                                  AccountImage: e['AccountImage'],
                                  AccountTitle: e['AccountTitle'],
                                  AccountPhoneNo: e['AccountPhoneNo'],
                                  AccountBalance: e['AccountBalance'],
                                  AccountType: e['AccountType']));
                        
                      }).toList()),
                ),
              )
            ]);
          }
          else{
            return Text('I am here ');
          }
        });
  }
}
