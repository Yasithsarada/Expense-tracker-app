import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense/expense-list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense/expenses.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cntxt, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
          ),
          key: ValueKey(
            expenses[index],
          ),
          onDismissed: (direction) {
            removeExpense(expenses[index]);
            print(index);
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}
