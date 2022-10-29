import 'package:account_book/Pages/Account/AddAccount.dart';
import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/widgets/highlightbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Pages/Account/Accounts.dart';
import 'Pages/Cash/Cash.dart';
import 'Pages/UserAccount/MyAccount.dart';
//import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  int _PageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(
        'Height : ${Dimensions.screenHeight} Width : ${Dimensions.screenWidth}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Account Book'),
      ),
      body: Container(
        //padding: EdgeInsets.all(20),
        padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 70),
        // alignment: Alignment.center,
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: pages[_PageIndex],
            ),
          ),
        ]),
      ),
      floatingActionButton: Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child:
              // _PageIndex == 1
              //           ?
              Container(
//width:double.maxFinite,
            // alignment: Alignment.bottomCenter,

            padding: EdgeInsets.only(bottom: 0, right: 15, left: 15),

            margin: EdgeInsets.only(
              left: 30,
              bottom: 0,
              right: 0,
            ),

            decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                // color: Colors.white
                ),

            child: Container(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,

              child: _PageIndex == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton.extended(
                          backgroundColor: Colors.green,
                          onPressed: () => {},
                          label: Container(
                              width: Dimensions.height40 * 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cash in'),
                                  Icon(Icons.arrow_downward_outlined),
                                ],
                              )),
                        ),
                        FloatingActionButton.extended(
                            backgroundColor: Colors.red,
                            onPressed: () => {},
                            label: Container(
                                width: Dimensions.height40 * 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Cash out'),
                                    Icon(Icons.arrow_upward_outlined),
                                  ],
                                ))),
                      ],
                    )
                  : _PageIndex == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              backgroundColor: AppColors.mainColor,
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddAccount()),
                                )
                              },
                              label: Container(
                                  width: Dimensions.height40 * 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: Dimensions.height10,
                                      ),
                                      Text('Add Account'),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              backgroundColor: Colors.red,
                              onPressed: () => {
                           
                              },
                              label: Container(
                                  width: Dimensions.height40 * 7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout),
                                      SizedBox(
                                        width: Dimensions.height10,
                                      ),
                                      Text('Logout'),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                     
            ),
          )
          //:Text('data'),
          ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _PageIndex,
        selectedItemColor: AppColors.mainColor,
        items: items,
        onTap: ((value) => {
              setState(() {
                _PageIndex = value;
              })
            }),
      ),
    );
  }

  List<Widget> pages = [Accounts(), Cash(), MyAccount()];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Accounts'),
    BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Cash'),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: 'My Account',
    ),
  ];
}
