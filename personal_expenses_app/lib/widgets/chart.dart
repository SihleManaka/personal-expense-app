
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String,Object>>get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum=0.0;

      for(var i=0; i < recentTransactions.length; i++){
        if(recentTransactions[i].transactionDate.day == weekDay.day &&
            recentTransactions[i].transactionDate.month == weekDay.month &&
            recentTransactions[i].transactionDate.year == weekDay.year){

          totalSum += recentTransactions[i].amount;

        }
      }
      print(DateFormat.E().format(weekDay).substring(0,1));
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),'amount':totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending{

    return groupedTransactionValues.fold(0.0, (sum, item){
      return sum + item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((data){
              return Flexible( // distribute available space to row and column space children
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0 ? 0.0 : (data['amount'] as double)  / totalSpending),
              );
            }).toList(),
          ),
        ),
      );
  }
}
