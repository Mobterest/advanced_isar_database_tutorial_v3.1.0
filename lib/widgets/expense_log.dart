import 'package:expensetracker/util/func.dart';
import 'package:expensetracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseLog extends ConsumerStatefulWidget {
  const ExpenseLog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseLogState();
}

class _ExpenseLogState extends ConsumerState<ExpenseLog> with Func {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/filterby");
              },
              icon: const Icon(
                Icons.tune,
                color: Colors.teal,
              )),
        ),
        FutureBuilder(
            future: expensesByCount(),
            builder: (context, snapshot) {
              return Text(
                "${snapshot.data} items",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.teal),
              );
            }),
        const ExpenseListWidget(
          filter: false,
          all: true,
        )
      ],
    );
  }
}
