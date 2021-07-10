import 'package:flutter/material.dart';

import './widgets/new_transactions.dart';
import './widgets/transaction_List.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green[200],
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
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
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String titleInput, double amountInput, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: titleInput,
      amount: amountInput,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      backgroundColor: Colors.green[300],
      title: Text(
        'Personal Expenses',
        style: TextStyle(
          // fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView(
          children: (mediaQuery.orientation == Orientation.portrait)
              ? [
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.45,
                    child: ChartView(_recentTransactions),
                  ),
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.55,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction),
                  ),
                ]
              : [
                  Container(
                    height: mediaQuery.size.height * 0.7,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: ChartView(_recentTransactions),
                  ),
                  Container(
                    height: mediaQuery.size.height * 0.4,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child:
                        TransactionList(_userTransactions, _deleteTransaction),
                  ),
                ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Opacity(
        opacity: mediaQuery.orientation == Orientation.portrait ? 1 : 0,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
