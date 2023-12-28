import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/rendering.dart';

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
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    print('heyy');
    return LayoutBuilder(
      builder: (cntxt, constraints) {
        print(constraints.maxHeight);
        print(constraints.minHeight);
        return SizedBox(
          height: double.infinity,
          // width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, keyboardSpace + 20),
              child: Column(
                children: [
                  if (constraints.maxWidth >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text(
                                "Tittle",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            maxLength: 50,
                            decoration: const InputDecoration(
                                label: Text("Amount"), prefixText: '\$ '),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                          label: Text(
                        "Tittle",
                      )),
                    ),
                  if (constraints.maxWidth > 600)
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
                        ),
                      ],
                    )
                  else
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
                  if (constraints.maxWidth > 600)
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: _submitExpenseData,
                            child: const Text("Save expense")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                      ],
                    )
                  else
                    Row(
                      children: [
                        const Spacer(),
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
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                        label: Text(
                      "Tittle",
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, keyboardSpace + 20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                    label: Text(
                  "Tittle",
                )),
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
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                    label: Text(
                  "Tittle",
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
