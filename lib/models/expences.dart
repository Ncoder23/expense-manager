import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { work, entertainment, school, other }

const Map<Category, IconData> categoryIcons = {
  Category.school: Icons.school,
  Category.work: Icons.work,
  Category.entertainment: Icons.movie,
  Category.other: Icons.new_label,
};
const uuid = Uuid();
DateFormat dateFomatter = DateFormat.yMd();

class Expences {
  Expences({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  String get formatedDate {
    return dateFomatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expences> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expences> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
