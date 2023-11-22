import 'package:flutter/material.dart';

class ExpenseDate extends StatelessWidget {
  const ExpenseDate({super.key, required this.date, required this.day});

  final String date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Text(
          date,
          style:
              const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          day,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
