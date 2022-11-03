import 'package:account_book/configurations/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configurations/BigText.dart';
import '../configurations/Dimensions.dart';
import '../configurations/SmallText.dart';

class IconBox extends StatelessWidget {
  final IconData BoxIcon;
  final String BoxText;
  final double BoxWidth;
  final String BoxLink;
  late Uri _url ;

  IconBox(
      {super.key,
      required this.BoxIcon,
      required this.BoxText,
      required this.BoxWidth,
      required this.BoxLink
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
                   Uri.parse(BoxLink),
                   print('${Uri} link $BoxLink'),
                   _launchUrl   ,
                   
                    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor:AppColors.mainColor,
                  content: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: Colors.white,
                        ),
                        SizedBox(width: Dimensions.width10,),
                        Text('$BoxLink'),
                      ],
                    ),
                  )),
            ), 




      },
      child: Container(
          margin:
              EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
          padding: EdgeInsets.only(
              top: Dimensions.height15,
              bottom: Dimensions.height15,
              left: Dimensions.width20,
              right: Dimensions.width20),
              
       //  width:BoxWidth,
          //Dimensions.width20 * 5,
          //height: (Dimensions.height40*2),
    
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.circular(Dimensions.height10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                BoxIcon,
                size: 20,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              SmallText(
                text: BoxText,
                color: AppColors.mainColor,
              )
            ],
          )),
    );
  }



    Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    print('Error');
    throw 'Could not launch $_url';
   
  }
}
}
