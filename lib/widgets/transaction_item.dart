import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:date_format/date_format.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transactions,
    @required this.deleteTxn,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTxn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transactions.amount}'),
            ),
          ),
        ),
        title: Text(
          transactions.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          formatDate(transactions.date,
              [D, " ", dd, '/', mm, '/', yyyy]),
        ),
        trailing: MediaQuery.of(context).size.width > 580
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transactions.id))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transactions.id)),
      ),
    );
  }
}
