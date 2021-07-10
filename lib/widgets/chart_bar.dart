import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingAmountPercentage;

  ChartBar(this.label, this.spendingAmount, this.spendingAmountPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
          Container(
            height: constraints.maxHeight * 0.115,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
          Container(
            height: constraints.maxHeight * 0.685,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green[50], width: 1),
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingAmountPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
          Container(
            height: constraints.maxHeight * 0.10,
            child: Text(
              '$label',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
        ],
      );
    });
  }
}
