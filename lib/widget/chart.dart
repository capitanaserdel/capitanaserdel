import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/model/transaction.dart';
import 'package:task/widget/chart_bar.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTx;
 Chart(this.recentTx);
   List<Map<String, Object>> get gTV {
     return List.generate(7, (index) {
       final weekDay = DateTime.now().subtract(Duration(days: index));
       var totalSum = 0.0;

       for (var i = 0; i < recentTx.length; i++){
         if(recentTx[i].date.day == weekDay.day &&
         recentTx[i].date.month == weekDay.month &&
             recentTx[i].date.year == weekDay.year){
             totalSum += recentTx[i].amount;
         }
       }
      return {'day' : DateFormat.E().format(weekDay).substring(0,1), 'amount' : totalSum};
     }).reversed.toList();
   }

   double get maxSp{
     return gTV.fold(0, (sum, item) {
       return sum + (item['amount'] as double);
     });
   }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: gTV.map((data){
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar((data['day'] as String),  (data['amount'] as double),maxSp == 0 ? 0 : (data['amount'] as double) / maxSp));
          }).toList(),),
        )
      );
  }
}
