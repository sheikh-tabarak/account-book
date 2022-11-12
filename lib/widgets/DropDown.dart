import 'package:account_book/configurations/AppColors.dart';
import 'package:account_book/configurations/Dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

List<String> list = <String>['Customer', 'Supplier', 'Others'];
late String SelectedValue;

String GetdropdownValue() {
  return SelectedValue;
}

class DropDown extends StatefulWidget {
  DropDown({super.key});
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.maxFinite,
      decoration: BoxDecoration(
          //  color: AppColors.mainColor,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(
        // isExpanded=true,
        isExpanded: true,
        borderRadius: BorderRadius.circular(4),
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        // elevation: 40,
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            SelectedValue = dropdownValue;
            print(SelectedValue);
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  SizedBox(width: Dimensions.width5,),
                  Icon(Icons.account_tree, color: Colors.grey,),
                  SizedBox(width: Dimensions.width10,),
                  Text(value),
                ],
              ));
        }).toList(),
      ),
    );
  }
}
