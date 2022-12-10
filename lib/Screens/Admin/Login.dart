import 'package:account_book/HomePage.dart';
import 'package:account_book/Screens/Admin/Signup.dart';
import 'package:account_book/configurations/SmallText.dart';
import 'package:account_book/databases/FlutterFire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../configurations/AppColors.dart';
import '../../configurations/BigText.dart';
import '../../configurations/Dimensions.dart';
import '../../databases/DataStreams.dart';
import '../../models/UserModel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //late UserModel Current_User;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool IsUserExist = false;
  bool IsPasswordCorrect = false;

  late String usernamemessage = '';
  late IconData usericon;
  int userLock = 0;

  late String passwordmessage = '';
  late IconData passicon;

  @override
  Widget build(BuildContext context) {
    @override
    initState() => {
          _emailController.text = 'test@gmail.com',
          _passwordController.text = 'testuser'
        };

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
                      text: "Login",
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

          // decoration: BoxDecoration(border: OutlineInputBorder()),
          child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: AllUsers(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      return Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              //  color: Colors.white,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (String value) =>
                                    {print(_emailController.text)},
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email ',
                                  errorText: usernamemessage,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusColor: Colors.yellow,
                                  hoverColor: Colors.green,
                                  suffixIconColor: Colors.pink,
                                  suffixIcon: Icon(
                                    IsUserExist
                                        ? Icons.check_circle
                                        : Icons.error,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //  color: Colors.white,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: _passwordController,
                                onChanged: (String value) =>
                                    {print(_passwordController.text + value)},
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password ',
                                  errorText: passwordmessage,
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(
                                    IsPasswordCorrect
                                        ? Icons.check_circle
                                        : Icons.lock,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.mainColor),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                fixedSize: MaterialStateProperty.all(
                                    Size.fromWidth(Dimensions.width30 * 10.5)),
                              ),
                              onPressed: () async {
                                bool shouldNavigate = await signIn(
                                    _emailController.text,
                                    _passwordController.text);
                                    print(shouldNavigate);

                                if (shouldNavigate) {
                                  
                                  print(_emailController.text );
                                  // to get the user Object in to the start of login !!!

                                  // StreamBuilder(
                                  //     stream: AllUsers(),
                                  //     builder:
                                  //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  //       if (!snapshot.hasData) {
                                  //         return Center(
                                  //             child: Center(
                                  //           child: CircularProgressIndicator(),
                                  //         ));
                                  //       } else if (snapshot.hasError) {
                                  //         return Text('Error');
                                  //       } else {
                                  //         return Column(children: [
                                  Row(
                                      children: snapshot.data!.docs.map((e) {
                                    if (e['email'] == _emailController.text &&
                                        e['password'] ==
                                            _passwordController.text) {
                                      print(e['email'] +
                                          ' = ' +
                                          _emailController.text);
                                      print(e['password'] +
                                          ' = ' +
                                          _passwordController.text);
                                           print('Done');
                                      // UserModel Current_User = UserModel(
                                      //   username: e['username'],
                                      //   email: e['email'],
                                      //   password: e['password'],
                                      //   phoneNo: e['phoneNo'],
                                      //   Cash: e['Cash'],
                                      //   TotalAccounts: e['TotalAccounts'],
                                      //   role: e['role'],
                                      // );
                                     
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(
                                              user: UserModel(
                                            username: e['username'],
                                            email: e['email'],
                                            password: e['password'],
                                            phoneNo: e['phoneNo'],
                                            Cash: e['Cash'],
                                            TotalAccounts: e['TotalAccounts'],
                                            role: e['role'],
                                          )),
                                        ),
                                      );
                                    }

                                    return Container(
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.zero,
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      width: 0,
                                      height: 0,
                                      child: Text(''),
                                    );
                                  }).toList(growable: false));

                                  //]);}});

                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //     HomePage(user:Current_User),
                                  //   ),
                                  // );

                                }
                              },
                              child: Container(
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
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Center(
                              child: SmallText(
                                text: 'Don\'t have an account ?',
                                color: Color.fromARGB(255, 174, 174, 174),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            FloatingActionButton.extended(
                              backgroundColor: Colors.red,
                              onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()),
                                )
                              },
                              label: Container(
                                  width: Dimensions.width30 * 9,
                                  //    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.account_circle),
                                      SizedBox(
                                        width: Dimensions.height10,
                                      ),
                                      Text('Create a New Account'),
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
                      ]);
                    }
                  })),
        ),
      ),

// ]);
//                             }
//                           })
    );
  }
}
