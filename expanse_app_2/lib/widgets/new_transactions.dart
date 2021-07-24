
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _salectedDate = DateTime.now();

  void _submitData(){

    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitlle = _titleController.text;
    final entetredAmount = double.parse(_amountController.text);

    if(enteredTitlle.isEmpty || entetredAmount <= 0 || _salectedDate == null){
      return;
    }
    widget.addTransaction(enteredTitlle, entetredAmount,_salectedDate);

    Navigator.of(context).pop(); //context added by State same with widget
  }

  void _presentDatePicker(){
    showDatePicker(context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2021),
    lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }

      setState(() {
        _salectedDate = pickedDate;
      });

    });


  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              /*onChanged: (value){ //register every key stroke
                titleInput = value;
              },*/
              onSubmitted: (_) =>_submitData(),
              controller: _titleController,
            ),
            TextField(
              decoration:InputDecoration(labelText: 'Amount'),
              //onChanged: (value)=>amountInput=value,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>_submitData(), //_unused argument
              controller: _amountController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _salectedDate == null ?
                      'NO date choose' :
                      'default date: ${DateFormat.yMd().format(_salectedDate)}',
                    ),
                  ),
                  FlatButton(onPressed: _presentDatePicker,
                      child: Text('Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add transaction'),
              //textColor: Colors.white,
              textColor: Theme.of(context).textTheme.button!.color,
              color: Theme.of(context).primaryColorDark,
              onPressed: _submitData,
            )
          ],),
      ),
    );
  }
}
