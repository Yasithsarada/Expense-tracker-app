import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense/expense-list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cntxt, index) => ExpenseItem(expenses[index]),
    );
  }
}
