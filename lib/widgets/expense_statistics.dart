import 'package:expensetracker/widgets/expense_general_statistics.dart';
import 'package:expensetracker/widgets/expense_log.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key, required this.view});

  final Map<int, bool> view;

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  int stats = 0;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.view[2]!,
        child: Column(
          children: [
            const Text(
              "Stats",
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ToggleSwitch(
                activeBgColor: const [Colors.teal, Colors.teal],
                initialLabelIndex: stats,
                minWidth: MediaQuery.of(context).size.width * 0.4,
                labels: const ['General', 'Expense log'],
                totalSwitches: 2,
                onToggle: (index) {
                  setState(() {
                    stats = index!;
                  });
                },
              ),
            ),
            (stats == 0) ? const GeneralStats() : const ExpenseLog()
          ],
        ));
  }
}
