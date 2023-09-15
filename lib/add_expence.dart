import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expence_tracker/models/expences.dart';

class AddExpcence extends StatefulWidget {
  AddExpcence(this.saveExp, {super.key});
  void Function(Expences) saveExp;
  @override
  State<AddExpcence> createState() => _AddExpcenceState();
}

class _AddExpcenceState extends State<AddExpcence> {
  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  DateTime? selecteddate = DateTime.now();
  DateFormat dateFormat = DateFormat.yMd();
  Category selectedcategory = Category.other;
  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    DateTime now = DateTime.now();
    //DatePicker gives a Future
    // showDatePicker(
    //   context: context,
    //   initialDate: now,
    //   firstDate: DateTime(now.year - 1, now.month, now.day),
    //   lastDate: now,
    // ).then((value) {
    //   setState(() {
    //     selecteddate = value;
    //   });
    // });
    selecteddate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      selecteddate = selecteddate;
    });
  }

  @override
  Widget build(BuildContext context) {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          //padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(
            children: [
              const Text("Add New Expence"),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Enter title"),
                ),
                style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        label: Text("Enter Amount"),
                        prefix: Text("\$"),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dateFormat.format(selecteddate!),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        IconButton(
                          onPressed: _datePicker,
                          icon: Icon(Icons.date_range),
                          padding: EdgeInsets.all(12),
                          iconSize: 32,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: DropdownButton(
                      items: Category.values
                          .toList()
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toUpperCase(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedcategory = value!;
                        });
                      },
                      value: selectedcategory,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancle"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //print(titleController.text);
                      if ((titleController.text.trim().isEmpty) ||
                          (amountController.text.trim().isEmpty) ||
                          double.tryParse(amountController.text)! <= 0) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text(
                                  "Error",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.red,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("Okay"),
                                  )
                                ],
                                content: const Text(
                                  "Enter valid Title, Amount and Date",
                                  style: TextStyle(fontSize: 22),
                                ),
                              );
                            });
                      } else {
                        Expences newExp = Expences(
                            title: titleController.text,
                            amount: double.tryParse(amountController.text)!,
                            date: selecteddate!,
                            category: selectedcategory);
                        widget.saveExp(newExp);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
