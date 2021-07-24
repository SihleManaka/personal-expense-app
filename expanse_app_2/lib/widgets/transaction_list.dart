import 'package:expanse_app_2/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions,this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: transactions.isEmpty ? Column(children: [
        Text('No Transactions added yet',style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 20,),
        Container(
          height: 500,
            child: Image.asset('assests/images/waiting.png',
              fit: BoxFit.cover,)
        ),
      ],) : ListView.builder(
        itemBuilder: (context,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5
            ),
            child: ListTile(
              leading: CircleAvatar(radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                      child: Text('R ${transactions[index].amount}')),
                ),
              ),
              title: Text(transactions[index].title,
              style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)
              ),
              trailing: IconButton(icon:  Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                tooltip: 'Delete transaction',
                onPressed: ()=>deleteTransaction(transactions[index].id), //to pass a reference to an annoynous function
              ),
            ),
          );
        },
        itemCount: transactions.length,
        ),
    );
  }
}
