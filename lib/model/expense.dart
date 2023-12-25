import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.work: Icons.work_rounded,
  Category.leisure: Icons.movie
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.categeroy,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.categeroy)
      : expenses = allExpenses
            .where((element) => element.category == categeroy)
            .toList();

  final Category categeroy;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
