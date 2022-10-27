import 'package:account_book/classes/DummyData.dart';
import 'AcountTransactions.dart';

class AccountsC {
final int AccountId;
final String AccountImage;
final String AccountTitle;
final String AccountPhoneNo;
final double AccountBalance;
final String AccountType;
//AccountTransactions f;
//var ATransactions=[];

  AccountsC({
    required this.AccountId,
    required this.AccountImage,
    required this.AccountTitle,
    required this.AccountPhoneNo,
    required this.AccountBalance,
    required this.AccountType,
   // required this.f,
  });
}


double TotalBalanceOverall(){
double balance=0;
double positive=0, negative=0;

for (var i = 0; i < AccountsData.length; i++){

  if (AccountsData[i].AccountBalance<0) {
    negative=negative+(-AccountsData[i].AccountBalance);
  }
  else if(AccountsData[i].AccountBalance>=0){
positive=positive+AccountsData[i].AccountBalance;
}}
balance=positive-negative;
return balance;
}


double PositiveBalance(){

double positive=0;

for (var i = 0; i < AccountsData.length; i++){

if(AccountsData[i].AccountBalance>=0){
positive=positive+AccountsData[i].AccountBalance;
}}
return positive;
}


double NegativeBalance(){

double negative=0;

for (var i = 0; i < AccountsData.length; i++){

if(AccountsData[i].AccountBalance<0){
negative=negative+(-AccountsData[i].AccountBalance);
}}
return negative;
}




