import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transactions_form.dart';
import 'package:expenses/widgets/transactions_list.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue
        ).copyWith(
            secondary: Colors.lightBlue
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<TransactionModel> _userTransactions = [
    TransactionModel(id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    TransactionModel(id: 't2', title: 'Weekly groceries', amount: 16.53, date: DateTime.now()),
  ];

  List<TransactionModel> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = TransactionModel(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return  GestureDetector(
          child: TransactionsForm(_addNewTransaction),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: (
                  MediaQuery.of(context).size.height
                      - appBar.preferredSize.height
                      - MediaQuery.of(context).padding.top
              ) * 0.3,
                child: Chart(_recentTransactions)
            ),
            Container(
              height: (
                  MediaQuery.of(context).size.height
                      - appBar.preferredSize.height
                      - MediaQuery.of(context).padding.top
              ) * 0.7,
                child: TransactionsList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
