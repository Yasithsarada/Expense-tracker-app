import 'package:expense_tracker/widgets/expense/expense-list/new_expense.dart';
import 'package:expense_tracker/widgets/expense/expense_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (cntxt) {
          return NewExpense();
        });
  }

  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'breakfast',
        amount: 2.5,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Petrol',
        amount: 40,
        category: Category.travel,
        date: DateTime.now()),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: openAddExpenseOverlay,
        )
      ], title: Text("Flutter Expense Tracker")),
      body: Column(
        children: [
          Text("Expenses"),
          Expanded(
            child: ExpenseList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
