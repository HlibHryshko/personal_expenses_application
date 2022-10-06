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
            trailing: MediaQuery.of(context).size.width > 360 ?
            TextButton.icon(
                onPressed: () {
                  deleteTransaction(userTransactions[index].id);
                },
                icon: Icon(
                    Icons.delete,
                  color: Colors.deepOrange,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ))
                :
            IconButton(
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

