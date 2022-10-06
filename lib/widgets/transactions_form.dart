import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsForm extends StatefulWidget {
  final Function _addNewTransaction;

  TransactionsForm(this._addNewTransaction);

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount > 0 && enteredTitle.isNotEmpty){
      widget._addNewTransaction(
        enteredTitle,
        enteredAmount,
        _selectedDate ?? DateTime.now()
      );
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker () {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2003),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if (pickedDate == null){
       return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    

  }



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitTransaction,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTransaction,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                          ?
                        'No date chosen'
                          :
                           'Date picked: ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                            'Choose date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitTransaction,
                child: Text('add transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

