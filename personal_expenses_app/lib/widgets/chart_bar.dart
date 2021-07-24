import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendigPartOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendigPartOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,contraints){
      return Column(
        children: <Widget>[
          Container(
            height: contraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}')
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          Container(
            height: contraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromARGB(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox( heightFactor: spendigPartOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                )
              ],
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          Container(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(label)
              )
          )
        ],
      );
    },);
  }
}
