import 'package:expensetracker/providers/expense/expense_provider.dart';
import 'package:expensetracker/widgets/expense_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collections/expense.dart';
import '../util/config.dart';

class ExpenseListWithoutFilter extends StatelessWidget {
  const ExpenseListWithoutFilter(
      {super.key, required this.snapshot, required this.ref});

  final AsyncSnapshot<List<Expense?>> snapshot;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.teal),
            secondaryBackground: Container(
              color: Colors.teal,
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "DELETE",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ),
            onDismissed: (direction) {
              ref
                  .watch(expenseFilterProvider.notifier)
                  .deleteExpense(snapshot.data![index]!);
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ExpenseDetail.routeName,
                    arguments: ExpenseDetailArguments(
                        expense: snapshot.data![index]!));
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/${categories[snapshot.data![index]!.category!.index]["icon"]}",
                    width: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListTile(
                      title: Text(
                        categories[snapshot.data![index]!.category!.index]
                            ["name"],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        "\$ ${snapshot.data?[index]?.amount}",
                        style: const TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  //name, date, amount
                ],
              ),
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
        itemCount: snapshot.data!.length);
  }
}
