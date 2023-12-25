import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(Expense expense1) addExpense;

  @override
  createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //approach 1 - get the valuse in text editin fields
  // var _enteredTitle;

  // _saveTitleInput(String input) {
  //   _enteredTitle = input;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    _pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _pickedDate = _pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _pickedDate == null) {
      showDialog(
        context: context,
        builder: (cntxt) => AlertDialog(
          title: const Text("Invalid Input !"),
          content: const Text(
              "Enter valid title , amount and date to create a expense !"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
    widget.addExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount!,
        category: _selectedCategory,
        date: _pickedDate!,
      ),
    );
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Tittle" ,)),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: '\$ '),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDate == null
                        ? "Select Date"
                        : dateFormatter.format(_pickedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((e) => DropdownMenuItem(
                        value: e, child: Text(e.name.toString())))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    if (val == null) {
                      return;
                    }
                    _selectedCategory = val;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("Save expense")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
            ],
          ),
        ],
      ),
    );
  }
}
