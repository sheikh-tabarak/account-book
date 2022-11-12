import 'package:account_book/databases/DataStreams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../configurations/SmallText.dart';
import '../../models/AccountsModel.dart';
import '../../configurations/AppColors.dart';
import '../../configurations/BigText.dart';
import '../../configurations/Dimensions.dart';
import '../../widgets/TableElement.dart';
import '../../widgets/highlightbox.dart';

class Cash extends StatelessWidget {
  const Cash({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error = ${snapshot.error}');

                              else if (snapshot.hasData) {
                                var output = snapshot.data!.data();
                                var value =
                                    output!['Cash']; // <-- Your value
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    HighlightBox(
                                        size: Dimensions.height40 * 4,
                                        color: value >= 0
                                            ? AppColors.SucessColor
                                            : AppColors.DangerColor,
                                        textColor:
                                            value >= 0 ? Colors.green : Colors.red,
                                        text: value >= 0
                                            ? '$value'.toString()
                                            : '${(value * -1).toString()}',
                                        message: 'Cash this Month',
                                        ArrowIcon: value >= 0
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward),

                                            HighlightBox(
                                        size: Dimensions.height40 * 4,
                                        color: value >= 0
                                            ? AppColors.SucessColor
                                            : AppColors.DangerColor,
                                        textColor:
                                            value >= 0 ? Colors.green : Colors.red,
                                        text: value >= 0
                                            ? '$value'.toString()
                                            : '${(value * -1).toString()}',
                                        message: 'Total Cash',
                                        ArrowIcon: value >= 0
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward),
                                  ],
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),














            // HighlightBox(
            //   size: Dimensions.height40*4,
            //   text:'99',
            //   ArrowIcon: Icons.arrow_upward,
            //   message: 'Amount to give',
            //   textColor: Colors.green,
            //   color: AppColors.SucessColor,
            // ),
            // HighlightBox(
            //   size: Dimensions.height40*4,
            //   ArrowIcon: Icons.arrow_downward,
            //   message: 'Amount to get',
            //   textColor: Colors.red,
            //   text: '10',
            //   color: AppColors.DangerColor,
            // ),
        
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height10, bottom: Dimensions.height10),
          padding: EdgeInsets.all(Dimensions.height5),
          height: 50,
          width: double.maxFinite,
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                width: 260,
                height: 25,
                child: TextField(),
              ),
              Icon(Icons.search),
              Icon(Icons.picture_as_pdf),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: 'Cash Records',
                size: Dimensions.font15,
              ),
            ],
          ),
        ]),
        SizedBox(
          height: Dimensions.height10,
        ),


        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Table(

                                    //  TableCellVerticalAlignment.middle,
                                    columnWidths: const <int, TableColumnWidth>{
                                      0: FlexColumnWidth(),
                                      1: FixedColumnWidth(90),
                                      2: FixedColumnWidth(90),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(children: <TableCell>[
                                        TableCell(
                                            //   verticalAlignment: TableCellVerticalAlignment.bottom,
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: SmallText(
                                                  text: 'Date',
                                                  size: 12,
                                                ))),
                                        TableCell(
                                            //   verticalAlignment: TableCellVerticalAlignment.baseline,
                                            child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: 'Cash Out',
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            //    verticalAlignment: TableCellVerticalAlignment.baseline,
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(
                                              text: 'Cash In',
                                              size: 12,
                                            ),
                                          ],
                                        )),
                                      ])
                                    ]),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Container(
                                  child: StreamBuilder(
                                      stream: CashTransactionsOfCurrentUser(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.red,
                                              color: Colors.white,
                                            ),
                                            //   Text('No Relvant Data => ${snapshot.data} =>')
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('Error');
                                        } else {
                                          //     final transaction = snapshot.data;

                                          return Container(
                                            child: SingleChildScrollView(
                                              child: ListView(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: snapshot.data!.docs
                                                      .map((e) {
                                                    //  print(e['AccountTransactions'][0]['description']);
                                                    return TableElement(
                                                        DateCell:
                                                            //   e['AccountTransactions'].length,
                                                            //[0]['description'],
                                                            e['dateTime']
                                                                .toDate(),
                                                        DescriptionCell:
                                                            e['Description']
                                                                .toString(),
                                                        //    'Description',

                                                        //e['AccountTransactions'][0]['description'].toString(),

                                                        TransactionUp:
                                                            (e['type'] == true)
                                                                ? (e['Amount'])
                                                                : (0.0),
                                                        TransactionDown:
                                                            (e['type'] ==
                                                                    false)
                                                                ? (e['Amount'])
                                                                : (0.0),
                                                        TransactionBalance: e[
                                                            'TotalCash']);
                                                  }).toList()),
                                            ),
                                          );
                                        }
                                        // else {
                                        //   return CircularProgressIndicator();
                                        // }
                                      }),
                                ),
                              ],
                            ),
                          ),
                       










              
              
              
              // TableElement(
              //         DateCell: DateTime.now(),
              //         DescriptionCell: 'Sold my Phone',
              //         TransactionUp: 2000,
              //         TransactionDown: 0,
              //         TransactionBalance: 100,)
    

      ],
    );
  
  
  }
}
