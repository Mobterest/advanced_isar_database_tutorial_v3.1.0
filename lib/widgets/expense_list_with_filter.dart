import 'package:expensetracker/providers/expense/expense_provider.dart';
import 'package:expensetracker/widgets/expense_empty_widget.dart';
import 'package:expensetracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/config.dart';
import 'expense_detail.dart';

class ExpenseListWithFilter extends StatelessWidget {
  const ExpenseListWithFilter(
      {super.key, required this.ref, required this.widget});

  final WidgetRef ref;
  final ExpenseListWidget widget;

  @override
  Widget build(BuildContext context) {
    return (ref.watch(expenseFilterProvider).isEmpty)
        ? const ExpenseEmptyWidget(subtitle: "No results available")
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ExpenseDetail.routeName,
                      arguments: ExpenseDetailArguments(
                          expense: ref.watch(expenseFilterProvider)[index]));
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/${categories[ref.watch(expenseFilterProvider)[index].category!.index]["icon"]}",
                      width: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ListTile(
                        title: Text(
                          categories[ref
                              .watch(expenseFilterProvider)[index]
                              .category!
                              .index]["name"],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        trailing: Text(
                          "\$ ${ref.watch(expenseFilterProvider)[index].amount}",
                          style: const TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                    //name, date, amount
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.teal,
                thickness: 0.5,
                indent: 50,
              );
            },
            itemCount: ref.watch(expenseFilterProvider).length);
  }
}
