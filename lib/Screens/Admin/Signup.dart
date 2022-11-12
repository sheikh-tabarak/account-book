import 'package:account_book/HomePage.dart';
import 'package:account_book/Screens/Admin/Login.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../configurations/AppColors.dart';
import '../../configurations/BigText.dart';
import '../../configurations/Dimensions.dart';
import '../../databases/FlutterFire.dart';
import '../../models/UserModel.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
      final TextEditingController _phoneNoController = TextEditingController();
      final TextEditingController _emailController = TextEditingController();


  bool IsUserExist = false;
  bool IsPasswordCorrect = false;

  late String usernamemessage = '';
  late IconData usericon;
  int userLock = 0;

  late String passwordmessage = '';
  late IconData passicon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          // SliverAppBar(

          // )
          AppBar(
              backgroundColor: AppColors.mainColor,
              toolbarHeight: Dimensions.height40 * 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              )),
              title: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/accountbooklogo.png',
                          ),
                        ),
                        //  borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    BigText(
                      text: "Create a New Account",
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              )),
      body: Center(
        child: Container(
          alignment: Alignment.center,

          padding: EdgeInsets.all(30),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  //  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(

                        controller: _usernameController,
                    onChanged: (String value) => {
                      print('CustomerAccountsData[0].username + == ' + value),

                      if (value == 'test')
                        {
                          print('Done'),
                          setState(() => {
                                IsUserExist = true,
                                print('test' + ' == ' + value)
                              })
                        }
                      else
                        {
                          setState(() => {
                                IsUserExist = false,
                              })
                        }
                 
                    },

                    decoration: InputDecoration(
                      labelText: 'Username',
                      errorText: usernamemessage,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusColor: Colors.yellow,
                      hoverColor: Colors.green,
                      suffixIconColor: Colors.pink,

                      suffixIcon: Icon(
                        IsUserExist ? Icons.check_circle : Icons.error,
                      ),
                    ),
                  ),
                ), 
                Container(
                  //  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(

                        controller: _emailController,
                    onChanged: (String value) => {
                      print('CustomerAccountsData[0].username + == ' + value),
                      if (value == 'test')
                        {
                          print('Done'),
                          setState(() => {
                                IsUserExist = true,
                                //   userLock = i,
                                print('test' + ' == ' + value)
                              })
                        }
                      else
                        {
                          setState(() => {
                                IsUserExist = false,
                              })
                        }
                      //  }
                    },
               //     initialValue: '',

                    decoration: InputDecoration(
                      labelText: 'Email ',
                      // focusedErrorBorder:Border(Border.all(color: AppColors.mainColor, width: 1))),
                      errorText: usernamemessage,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusColor: Colors.yellow,
                      hoverColor: Colors.green,
                      suffixIconColor: Colors.pink,

                      suffixIcon: Icon(
                        IsUserExist ? Icons.check_circle : Icons.error,
                      ),
                    ),
                  ),
                ), 



























                Container(
                  //  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    onChanged: (String value) => {
                      if (value == 'pass')
                        {
                          print('Done'),
                          setState(() => {
                                IsPasswordCorrect = true,
                                print('pass' + ' == ' + value)
                              })
                        }
                      else
                        {
                          setState(() => {
                                IsPasswordCorrect = false,
                              })
                        }
                    },
                //    initialValue: '',
                    decoration: InputDecoration(
                      labelText: 'Password ',
                      errorText: passwordmessage,
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        IsPasswordCorrect ? Icons.check_circle : Icons.lock,
                        //   color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
                  Container(
                  //  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: _phoneNoController,
                    onChanged: (String value) => {
                      // if (value == 'pass')
                      //   {
                      //     print('Done'),
                      //     setState(() => {
                      //           IsPasswordCorrect = true,
                      //           print('pass' + ' == ' + value)
                      //         })
                      //   }
                      // else
                      //   {
                      //     setState(() => {
                      //           IsPasswordCorrect = false,
                      //         })
                      //   }
                    },
               //     initialValue: '',
                    decoration: InputDecoration(
                      labelText: 'Mobile Number ',
                      errorText: passwordmessage,
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        IsPasswordCorrect ? Icons.check_circle : Icons.lock,
                        //   color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(
                  height: Dimensions.height10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Colors.red),
       shadowColor: MaterialStateProperty.all(Colors.black),
       padding: MaterialStateProperty.all(EdgeInsets.all(10)),
       fixedSize: MaterialStateProperty.all(Size.fromWidth(Dimensions.width30 * 10.5)),
    ),
                  
            //  MaterialButton(
              //  color: Colors.red,
                 // backgroundColor: Colors.red,
                  onPressed: ()  async {
                   bool shouldNavigate =
                      await register(_emailController.text, _passwordController.text);
                  if (shouldNavigate) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                    RegisterNewUser(_usernameController.text, _passwordController.text, _phoneNoController.text,_emailController.text);
                  }                  
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    
                      width: Dimensions.width30 * 9,
                      //    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle,color:Colors.white),

                         
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          Text('Sign up'),
                        ],
                      ))
                ),
 SizedBox(
                  height: Dimensions.height30,
                ),

                Center(child: SmallText(text:'Already have an account ?',color: Color.fromARGB(255, 174, 174, 174),)
                ,),
                 SizedBox(
                  height: Dimensions.height15,
                ),

 FloatingActionButton.extended(
                  backgroundColor: AppColors.mainColor,
                  onPressed: () => {
                    
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login()),
                    )
                  },
                  label: Container(
                      width: Dimensions.width30 * 9,
                      //    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          Text('Login'),
                        ],
                      )),
                ),
               
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Create a New Account',
                //     style: TextStyle(color: Colors.grey[600]),
                //   ),
                // ),

                // Container(
                //     height: 80,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
                //     ),
                //     padding: const EdgeInsets.all(20),
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(

                //         backgroundColor: AppColors.mainColor,
                //         minimumSize: const Size.fromHeight(50)
                //       ),
                //       child: const Text('Log In'),
                //       onPressed: () {
                //         if (IsUserExist == true && IsPasswordCorrect == true) {
                //           // Navigator.of(context).push(
                //           //     MaterialPageRoute(
                //           //         builder: (context) =>
                //           //             HomePage(
                //           //               userindex: userLock,
                //           //             )));
                //         }
                //       },
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
