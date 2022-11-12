import 'package:account_book/configurations/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:
Center(
      child:
      CircularProgressIndicator(
                backgroundColor: AppColors.mainColor,
                color: Colors.white,
              ),
    )
    );
    
  }
}