
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {

  final  List<Transaction> transactions;
  final Function deleteTransactionTx;

  TransactionList(this.transactions, this.deleteTransactionTx);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 450,
       child:
      transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            'No Transaction added yet!!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
              child: Image.asset('assets/images/waiting.png',fit: BoxFit.contain,)
          )
        ],
      ) : ListView.builder(
         itemBuilder: (context,index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6
              ),
              child: ListTile(
                leading: CircleAvatar(radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text('\$${transactions[index].amount}')),
                ),
                ),
                title: Text(transactions[index].title,
                  style:  Theme.of(context).textTheme.title,
                  ),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].transactionDate)),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () =>deleteTransactionTx(transactions[index].id),
                ),

              ),
            );
         },
         itemCount: transactions.length, //defines how many items should be built

        ),
      );

  }
}
