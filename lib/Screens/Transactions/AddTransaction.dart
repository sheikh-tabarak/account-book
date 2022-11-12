import 'dart:async';

import 'package:account_book/Screens/Transactions/AccountTransactions.dart';
import 'package:account_book/models/AccountsModel.dart';
import 'package:account_book/models/TransactionModel.dart';
import 'package:account_book/configurations/BigText.dart';
import 'package:account_book/databases/Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../configurations/AppColors.dart';
import '../../configurations/Dimensions.dart';

class AddTransaction extends StatefulWidget {
  final AccountsModel account;
  final String type;
  AddTransaction({super.key, required this.type, required this.account});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    dateController.text='${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}';
    super.initState();
  }
  

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
        
      //      dateController.text='${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}';



    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
       dateController.text='${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}';
      });
    }
  }

  final amountController = TextEditingController();
  final DescriptionController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: widget.type == 'get'
            ? Text('I got !!')
            : widget.type == 'give'
                ? Text('I gave !!')
                : Text('Error'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
              children: [
                TextField(
                  onTap: () {
                      _selectDate(context);
                            dateController.text='${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}';     
                  },
                  readOnly: true,
                  
                    controller: dateController,
                    onChanged: (String value) => {
                    print(value),
                    },
                    decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     
                      hintText: 'Choose Date',
                      
                      prefixIcon: IconButton(
                          onPressed: () {
                            _selectDate(context);
                            dateController.text='${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}';
                        
                          },
                          icon: Icon(Icons.calendar_today)),
                    )),

                    SizedBox(
                  height: Dimensions.height15,
                ),

                TextField(
                  controller: amountController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Amount',
                    prefixIcon: Icon(Icons.money)
                  ),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                TextField(
                //  cursorHeight: 50,
                  controller: DescriptionController,
                  onChanged: (String value) => {print(value)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Details (Optional)',
                    prefixIcon: Icon(Icons.description)
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
        margin: EdgeInsets.only(
          left: 30,
          bottom: 0,
          right: 0,
        ),
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.mainColor,
          onPressed: () => {
            CreateTransaction(
                widget.account,
                selectedDate,
                double.parse(amountController.text),
                widget.type,
                DescriptionController.text),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds:2),
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
                        Text('Transaction Successfully'),
                      ],
                    ),
                  )),
            ),
              Navigator.pop(context)
          },
          label: Container(
              width: Dimensions.height40 * 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  widget.type == 'get' ? Text('Recieve') : Text('Give'),
                ],
              )),
        ),
      ),
    );
  }
}
