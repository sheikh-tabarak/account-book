import 'package:account_book/HomePage.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(0),
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        IconButton(
                            onPressed: () => {
                                        //  Navigator.pop(context)
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => HomePage()),
                                  //)
                                },
                            icon: 
                            Container(
                                width: 30,
                                height: 30,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               
                               image :DecorationImage(image:NetworkImage(
                                    'https://raw.githubusercontent.com/jonataslaw/getx-community/master/getx.png'),
                                fit:BoxFit.cover),
                              ),),
                            
                          
                            ),

                            BigText(text: 'Customer Desc', color: Colors.white,)

                           
                            
                      ],
                    ),
                  )
                  //  AppIcon(icon: Icons.share)
                ],
              ),
            )));
  }
}
