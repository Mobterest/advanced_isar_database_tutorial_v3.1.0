import 'package:expensetracker/util/config.dart';
import 'package:expensetracker/widgets/expense_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../providers/expense/expense_provider.dart';

class ExpenseCategoryStatistics extends ConsumerWidget {
  const ExpenseCategoryStatistics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<double> total = ref.watch(expenseMainProvider);
    final AsyncValue<List<double>> sumByCategory =
        ref.watch(expenseCategoryProvider);

    return Card(
      child: Column(
        children: [
          const TitleWidget(title: "Expenses / Category", clr: Colors.teal),
          const SizedBox(
            height: 5.0,
          ),
          Column(children: buildWidget(sumByCategory, total))
        ],
      ),
    );
  }

  List<Widget> buildWidget(
      AsyncValue<List<double>> sumByCategory, AsyncValue<double> total) {
    List<Widget> indicators = [];

    final all = switch (total) {
      AsyncData(:final value) => value,
      AsyncError() => 0,
      _ => 0
    };

    for (int i = 0; i < categories.length; i++) {
      final sum = switch (sumByCategory) {
        AsyncData(:final value) => value[i],
        AsyncError() => 0,
        _ => 0
      };

      indicators.add(LinearPercentIndicator(
        animation: true,
        curve: Curves.bounceIn,
        width: 140.0,
        lineHeight: 7.0,
        percent: sum / all,
        backgroundColor: const Color.fromARGB(255, 214, 218, 217),
        progressColor: Colors.teal,
        trailing: Text(categories[i]["name"]),
      ));
    }
    return indicators;
  }
}
