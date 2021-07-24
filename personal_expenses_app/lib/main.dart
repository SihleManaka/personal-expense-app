import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'models/transaction.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expanses',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amberAccent,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
          button: TextStyle(color: Colors.white)
          ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.transactionDate.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        transactionDate: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final isLandscape= mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text('Personal expanses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        //creating own IOS button
        GestureDetector(
          child: Icon(CupertinoIcons.add),
          onTap: ()=> _startAddNewTransaction(context),
        )
        /*IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )*/
      ],),
    )
        : AppBar(
      title: Text('Personal expanses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    final transactionListWidget = Container(  // size.height take max height of the container widget * 0.6 for 70%
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) * 0.7, //padding is the default size flutter has for app info such as spcace arounf apps
        child: TransactionList(_userTransactions, _deleteTransaction)
    );

    final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('show chart'),
              Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart, onChanged: (value){
                setState(() {
                  _showChart = value;
                });
                print('I been switched');
              })
            ],),
          if(!isLandscape)  Container( //inlist if statement dont use {}
            height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *0.3,
            child: Chart(_recentTransactions),
          ),
          if(!isLandscape) transactionListWidget,
          if(isLandscape) _showChart ? Container(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) * 0.7,
              child: Chart(_recentTransactions)
          )
              :transactionListWidget
        ],
      ),
    )
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: pageBody,navigationBar: appBar,)
        : Scaffold(
      appBar: appBar, // assign appBar variable
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container()
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
