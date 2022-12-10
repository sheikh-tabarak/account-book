import 'dart:async';
import 'dart:io';
import 'package:account_book/Screens/Loading.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:account_book/models/AccountsModel.dart';
import 'package:account_book/widgets/DropDown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/Dimensions.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  String UploadedImage = '';
  @override
  void initState() {
    super.initState();
  }

  final titleController = TextEditingController();
  final phoneNoController = TextEditingController();
  String imagetoDatabase = '';
  String imagetoUpload = '';

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    const List<String> TypeList = <String>['Customer', 'Supplier', 'Other'];

   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Add Account'),
      ),
      body: 
      isLoading==false?
      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg'],
                    );
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error Uploading')));
                    } else {
                      final fileName = result.files.single.name;
                      final filePath = result.files.single.path!;
                      imagetoUpload=filePath;
                      // String ImageURL =
                      //     await uploadAccountImage(fileName, filePath);

                      setState(() {
                        UploadedImage = result.files.single.path!;
                      });
                    }
                  },
                  child: Container(
                      width: double.maxFinite,
                      height: 250,
                      decoration: BoxDecoration(
                        image: UploadedImage == ''
                            ? DecorationImage(
                                image: NetworkImage('url'), opacity: 0)
                            : DecorationImage(
                                image: new FileImage(
                                  File(UploadedImage),
                                ),
                                fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 243, 243, 243),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: UploadedImage == ''
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upload an Account Image',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Only PNG and JPG are allowed'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload_outlined,
                                          size: 50,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Click to choose  an image'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                    onPressed: () => {
                                          setState(() {
                                            UploadedImage = '';
                                          })
                                        },
                                    icon: Icon(
                                      Icons.delete_rounded,
                                      size: 20,
                                      color: Colors.red,
                                    )),
                              ),
                            )),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                TextField(
                  controller: titleController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Account Title',
                      prefixIcon: Icon(Icons.account_box)),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                TextField(
                  controller: phoneNoController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone ",
                      prefixIcon: Icon(Icons.phone)),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                DropDown(),
              ],
            )),
      ):
      Loading()
      ,
      floatingActionButton: 
      isLoading==false?
      Container(
        padding: EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
        margin: EdgeInsets.only(
          left: 30,
          bottom: 0,
          right: 0,
        ),
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.mainColor,
          onPressed: () async  {
            setState(() {
              isLoading=true;
            });
            
            String ImageURL =
             await uploadAccountImage('${titleController.text} | ${DateTime.now().toString()}',imagetoUpload,);
            AddNewAccount(ImageURL, titleController.text, phoneNoController.text,
                GetdropdownValue());
               
                
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.green,
                  content: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_box,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Text('Account Added Successfully'),
                      ],
                    ),
                  )),
            );
             setState(() {
                  isLoading=false;
                });
            //Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
           // });
          },
          label: Container(
              width: Dimensions.height40 * 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Add Account'),
                ],
              )),
        ),
      ):
        Text('')
      
      ,
    );
  }

  Future AddNewTransaction() async {
    final NewTransaction = {
      'AccountTransactions': FieldValue.arrayUnion([
        {
          'date': DateTime.now(),
          'description': 'Account is Created',
          'amount': 0,
          'type': 'created'
        }
      ])
    };
    final NewAccount1 = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('accounts')
        .doc();
    await NewAccount1.update(NewTransaction);
    //  TransactionItem()
  }
}
