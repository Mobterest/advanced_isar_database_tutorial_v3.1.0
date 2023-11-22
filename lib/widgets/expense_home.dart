import 'package:expensetracker/util/func.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense_date.dart';
import 'expense_header.dart';
import 'expense_list.dart';
import 'expense_title.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.view});

  final Map<int, bool> view;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with Func {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.view[0]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Expense Tracker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 16),
                ),
                const Spacer(),
                (loading)
                    ? const CircularProgressIndicator(
                        color: Colors.teal,
                      )
                    : IconButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await exportDataToFirebase();
                          setState(() {
                            loading = false;
                          });
                        },
                        icon: const Icon(Icons.sync)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/search");
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            const HeaderWidget(
              editBudget: true,
            ),
            const TitleWidget(
              title: "Expenses",
              clr: Colors.black,
            ),
            ExpenseDate(
                date: DateFormat.d().format(DateTime.now()),
                day: DateFormat.EEEE().format(DateTime.now())),
            const ExpenseListWidget(
              filter: false,
              all: false,
            )
          ],
        ));
  }
}
