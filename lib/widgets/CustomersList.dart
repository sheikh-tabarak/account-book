import 'package:account_book/Pages/AccountDetailPage.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../classes/DummyData.dart';

class CustomerList extends StatelessWidget {
  final String image;
  final String CustomerName;
  final double balance;
  final Color color;

  const CustomerList({
    Key? key,
    required this.image,
    required this.CustomerName,
    required this.balance,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: double.maxFinite,
            child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                //  physics: const NeverScrollableScrollPhysics(),
                itemCount: AccountsData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailPage()))
                    },

                    child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 197, 197, 197)))),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            image: DecorationImage(
                                                image: NetworkImage(AccountsData[index].AccountImage),
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Dimensions.width15,
                                  ),
                                  Column(
                                    
                                    children: [
                  
                                       Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: AccountsData[index].AccountTitle,
                                        size: Dimensions.font15,
                                      ),
                                      SizedBox(
                                        width: Dimensions.height40,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SmallText(
                                            text: 'Rs. ${AccountsData[index].AccountBalance}',
                                            color: AccountsData[index].AccountBalance>=0?Colors.green:Colors.red,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                    ]
                  
                                
                                  )
                                 
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
