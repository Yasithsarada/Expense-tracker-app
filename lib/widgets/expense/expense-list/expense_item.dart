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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 21, 110, 24),
                  fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${expenseItem.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenseItem.category]),
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
