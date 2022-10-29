import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // print(Get.context!.height);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:  HomePage(),
        // AnimatedSplashScreen(
        //     splashIconSize: double.infinity, //Dimensions.screenHeight,
        //     duration: 200,
        //     splash: Container(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image(
        //               width: 100,
        //               height: 100,
        //               image: AssetImage('assets/images/accountbooklogo.png')),
        //           BigText(
        //             text: 'Account Book',
        //             color: Colors.white,
        //             size: 20,
        //           ),
        //           SizedBox(height: 10),
        //           SmallText(
        //             text: 'By Tech Legion',
        //             size: 11,
        //             color: Colors.white,
        //             weight: FontWeight.w100,
        //           )
        //         ],
        //       ),
        //     ),
        //     nextScreen: HomePage(),
        //     splashTransition: SplashTransition.fadeTransition,
        //     backgroundColor: AppColors.mainColor),
            );
  }
}
