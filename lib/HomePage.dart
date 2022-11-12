import 'package:account_book/Screens/Accounts/AddAccount.dart';
import 'package:account_book/Screens/Admin/Login.dart';
import 'package:account_book/Screens/Cash/AddCashTransaction.dart';
import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/Accounts/Accounts.dart';
import 'Screens/Cash/Cash.dart';
import 'Screens/Admin/MyAccount.dart';
import 'models/UserModel.dart';
//import 'package:get/get.dart';

class HomePage extends StatefulWidget {
   final UserModel user;
  const HomePage({super.key, required this.user,});
 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _PageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //  print(
    //      'Height : ${Dimensions.screenHeight} Width : ${Dimensions.screenWidth}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Account Book'),
      ),
      body: Container(
        //padding: EdgeInsets.all(20),
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 70),
        // alignment: Alignment.center,
        child:
            //Expanded(
            //  child:
            SingleChildScrollView(
          child: 
        //  []
          
          
         pages[_PageIndex],
        ),
        //  ),
      ),
      floatingActionButton: Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.only(bottom: 0, right: 15, left: 15),
            margin: const EdgeInsets.only(
              left: 30,
              bottom: 0,
              right: 0,
            ),
            decoration: const BoxDecoration(
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
                          onPressed: () => {
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                           AddCashTransaction(Current_User: widget.user, type: 'get')))

                            },
                          label: SizedBox(
                              width: Dimensions.height40 * 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Cash in'),
                                  Icon(Icons.arrow_downward_outlined),
                                ],
                              )),
                        ),
                        FloatingActionButton.extended(
                            backgroundColor: Colors.red,
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                           AddCashTransaction(Current_User: widget.user, type: 'give')))
                                },
                            label: SizedBox(
                                width: Dimensions.height40 * 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
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
                                //    GetOneAccountTransactions("bqj2DKvVYUhbJXYLOmKO"),

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddAccount()),
                                )
                              },
                              label: SizedBox(
                                  width: Dimensions.height40 * 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.add),
                                      SizedBox(
                                        width: Dimensions.height10,
                                      ),
                                      const Text('Add Account'),
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                                FirebaseAuth.instance.signOut();
                              },
                              label: SizedBox(
                                  width: Dimensions.height40 * 7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.logout),
                                      SizedBox(
                                        width: Dimensions.height10,
                                      ),
                                      const Text('Logout'),
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

  List<Widget> pages = [Accounts(), const Cash(),  MyAccount()];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Accounts'),
    const BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Cash'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: 'My Account',
    ),
  ];
}
