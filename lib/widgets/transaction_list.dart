import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _lstTransactions;
  final Function _deleteTransaction;

  TransactionList(this._lstTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: _lstTransactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemCount: _lstTransactions.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                                  '\$${_lstTransactions[index].amount.toStringAsFixed(2)}')),
                        ),
                      ),
                      title: Text(
                        _lstTransactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(_lstTransactions[index].transactionDate)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          _deleteTransaction(_lstTransactions[index].id);
                        },
                      ),
                    ),
                  );
                }));
  }
}
