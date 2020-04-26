import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTxn(
      titleController.text,
      double.tryParse(amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) return;
      setState(() {
        _selectedDate = pickedData;
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            right: 10,
            left: 10,
          ),
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(_selectedDate)),
                  ),
                  Platform.isAndroid
                      ? CupertinoButton(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onPressed: _presentDatePicker,
                        )
                      : FlatButton(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onPressed: _presentDatePicker,
                        )
                ],
              ),
            ),
            Align(
              heightFactor: 4.5,
              alignment: Alignment.bottomCenter,
              child: Platform.isAndroid
                  ? CupertinoButton(
                      child: Text("Add Transaction"),
                      onPressed: submitData,
                      color: Colors.red,
                    )
                  : RaisedButton(
                      child: Text("Add Transaction"),
                      onPressed: submitData,
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
            )
          ]),
        ),
      ),
    );
  }
}
