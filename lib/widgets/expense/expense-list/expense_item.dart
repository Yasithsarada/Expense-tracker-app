import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expenseItem, {super.key});
  final Expense expenseItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expenseItem.title),
            const SizedBox(
              height: 5,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(category[expenseItem.category]),
                    SizedBox(width: 4),
                    Text(expenseItem.formatedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
