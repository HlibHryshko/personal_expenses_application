import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transactions_form.dart';
import 'package:expenses/widgets/transactions_list.dart';


import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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

  bool _showChart = false;

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

  List<Widget> _buildLandscapeContent(MediaQueryData mQuery, AppBar appBar, Widget transactionsListWidget) {
    return [
      Container(
      height: (
          mQuery.size.height
              - appBar.preferredSize.height
              - mQuery.padding.top
      ) * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show chart'),
          Switch(
              value: _showChart,
              onChanged: (val){
                setState(() {
                  _showChart = val;
                });
              }
          ),
        ],
      ),
    ),
      _showChart ? Container(
          height: (
              mQuery.size.height
                  - appBar.preferredSize.height
                  - mQuery.padding.top
          ) * 0.7,
          child: Chart(_recentTransactions)
      ) : transactionsListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mQuery, AppBar appBar, Widget transactionsListWidget) {
    return [Container(
        height: (
            mQuery.size.height
                - appBar.preferredSize.height
                - mQuery.padding.top
        ) * 0.3,
        child: Chart(_recentTransactions),
      ),
      transactionsListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final isLandscape = mQuery.orientation == Orientation.landscape;
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
    final transactionsListWidget = Container(
      height: (
          mQuery.size.height
              - appBar.preferredSize.height
              - mQuery.padding.top
      ) * 0.7,
      child: TransactionsList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLandscape)
                ..._buildLandscapeContent(
                    mQuery,
                    appBar,
                    transactionsListWidget
                ),
              if (!isLandscape)
                ..._buildPortraitContent(
                    mQuery,
                    appBar,
                    transactionsListWidget
                ),
            ],
          ),
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
