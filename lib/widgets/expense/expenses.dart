import 'package:expense_tracker/widgets/chart/chart.dart';
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
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (cntxt) {
          return NewExpense(
            addExpense: _addExpense,
          );
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

  void _addExpense(Expense expense) {
    print("lllllllllllppppppppppppppp");
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expenseToBeRomoved) {
    final indexRemove = _registeredExpenses.indexOf(expenseToBeRomoved);
    setState(() {
      _registeredExpenses.remove(expenseToBeRomoved);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 3000),
      content: const Text("Expense Deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(indexRemove, expenseToBeRomoved);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var avlbleWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: openAddExpenseOverlay,
        )
      ], title: const Text("Flutter Expense Tracker")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
        child: avlbleWidth < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ExpenseList(
                      removeExpense: removeExpense,
                      expenses: _registeredExpenses,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ExpenseList(
                      removeExpense: removeExpense,
                      expenses: _registeredExpenses,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
