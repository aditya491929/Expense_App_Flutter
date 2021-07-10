import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class ChartView extends StatelessWidget {
  final List<Transaction> recentTransactions;

  ChartView(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalWeekSpendings {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    // height: MediaQuery.of(context).size.height * 0.4,
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.7,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: groupedTransactionValues.map((data) {
                  // return Text('${data['day']} : ${data['amount']}');
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalWeekSpendings == 0.0
                          ? 0.0
                          : ((data['amount'] as double) / totalWeekSpendings),
                    ),
                  );
                }).toList(),
              ),
            ),
            Card(
              color: Colors.green[300],
              margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
              elevation: 5,
              child: Container(
                height: constraints.maxHeight * 0.270,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          'Total Expenditure',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          '\$ ${totalWeekSpendings.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )
          ],
        );
      }),
    );
  }
}
