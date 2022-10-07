import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionModel> userTransactions;
  final Function deleteTransaction;

  TransactionsList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isNotEmpty
        ?
    ListView.builder(
      itemBuilder: (context, index){
        return TransactionItem(userTransaction: userTransactions[index], deleteTransaction: deleteTransaction);
      },
      itemCount: userTransactions.length,
    )
    :
    LayoutBuilder(
      builder: (ctx, constraints){
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.2,
              child: Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight*0.05,
            ),
            Container(
              height: constraints.maxHeight*0.75,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }
}

