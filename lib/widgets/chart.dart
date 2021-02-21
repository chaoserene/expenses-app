import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < this.recentTransactions.length; i++) {
        if (this.recentTransactions[i].transactionDate.day == weekDay.day &&
            this.recentTransactions[i].transactionDate.month == weekDay.month &&
            this.recentTransactions[i].transactionDate.year == weekDay.year)
          totalSum += this.recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((group) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  group['day'],
                  group['amount'],
                  totalSpending == 0
                      ? 0
                      : (group['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
