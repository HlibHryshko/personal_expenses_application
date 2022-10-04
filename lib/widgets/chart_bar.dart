import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double amount;
  final double percentage;

  ChartBar(this.weekDay, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height: 20,
            child: FittedBox(
                child: Text('€${amount.toStringAsFixed(0)}'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
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
          const SizedBox(
            height: 5,
          ),
          Text(weekDay),
        ],
    );
  }
}
