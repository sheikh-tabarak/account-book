import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/widgets/highlightbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Pages/Accounts.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Account Book'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        // alignment: Alignment.center,
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: pages[_PageIndex],
            ),
          ),
        ]),
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

  List<Widget> pages = [Accounts(), Accounts(), Accounts()];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Accounts'),
    BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Cash'),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: 'My Account',
    ),
  ];
}
