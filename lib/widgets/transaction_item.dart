import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final TransactionModel userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: CircleAvatar(
              radius: 30,
              child: Text('\$${userTransaction.amount}'),
            ),
          ),
        ),
        title: Text(
          userTransaction.title,
        ),
        subtitle: Text(
          DateFormat('dd-MM-yyyy').format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360 ?
        TextButton.icon(
            onPressed: () {
              deleteTransaction(userTransaction.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.deepOrange,
            ),
            label: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.deepOrange,
              ),
            ))
            :
        IconButton(
          onPressed: (){
            deleteTransaction(userTransaction.id);
          },
          icon: const Icon(Icons.delete),
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}