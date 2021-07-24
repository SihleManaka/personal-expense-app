
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
      height: MediaQuery.of(context).size.height * 0.6,
       child:
      transactions.isEmpty ? 
      LayoutBuilder(builder: (context,constraints){

        return Column(
          children: <Widget>[
            Text(
              'No Transaction added yet!!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
                child: Image.asset('assets/images/waiting.png',fit: BoxFit.contain,)
            )
          ],
        );
      })
       : ListView.builder(
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
                trailing: MediaQuery.of(context).size.width > 460
                    ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('delete'),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () =>deleteTransactionTx(transactions[index].id,
                    )
                )
                    :IconButton(
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
