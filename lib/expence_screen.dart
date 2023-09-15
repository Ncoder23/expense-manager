import 'package:expence_tracker/add_expence.dart';
import 'package:expence_tracker/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/expence_list.dart';
import 'package:expence_tracker/models/expences.dart';

class ExpenceScreen extends StatefulWidget {
  @override
  State<ExpenceScreen> createState() {
    // TODO: implement createState
    return _ExpenceScreenState();
  }
}

class _ExpenceScreenState extends State<ExpenceScreen> {
  final List<Expences> expences = [
    Expences(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expences(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.entertainment,
    ),
    Expences(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expences(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.school,
    ),
  ];

  void _saveExpence(Expences newExpence) {
    setState(() {
      expences.add(newExpence);
    });
  }

  void _addExpence() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpcence(_saveExpence),
    );
  }

  void _removeExpence(Expences exp) {
    final _expenceIndex = expences.indexOf(exp);
    setState(() {
      expences.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        //backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expences.insert(_expenceIndex, exp);
            });
          },
        ),
        content: Text("Expence Deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Widget mainWidget = expences.isEmpty
        ? Center(
            child: Text(
              "Nothig Yet!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : width < 600
            ? Column(
                children: [
                  Chart(expenses: expences),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: ExpenceList(expences, _removeExpence)),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Chart(expenses: expences)),
                    Expanded(
                      child: ExpenceList(expences, _removeExpence),
                    ),
                  ],
                ),
              );
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Expence Tracker"),
          actions: [
            IconButton(
              onPressed: _addExpence,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: mainWidget,
      ),
    );
  }
}
