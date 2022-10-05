import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: CircleAvatar(
                  radius: 30,
                  child: Text('\$${userTransactions[index].amount}'),
                ),
              ),
            ),
            title: Text(
              userTransactions[index].title,
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy').format(userTransactions[index].date),
            ),
            trailing: IconButton(
              onPressed: (){
                deleteTransaction(userTransactions[index].id);
              },
              icon: Icon(Icons.delete),
              color: Colors.deepOrange,
            ),
          ),
        );
      },
      itemCount: userTransactions.length,
    )
    :
    Column(
      children: [
        Text(
          'No transactions added yet!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

