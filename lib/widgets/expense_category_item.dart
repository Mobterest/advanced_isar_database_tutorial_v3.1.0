import 'package:expensetracker/util/config.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryItem extends StatelessWidget {
  const ExpenseCategoryItem(
      {super.key, required this.index, required this.selectedItem});

  final int index;
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (index == selectedItem) ? const Color(0xffA4D6D1) : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/${categories[index]["icon"]}",
            width: 40,
          ),
          Text(
            categories[index]["name"],
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: (index == selectedItem)
                    ? Colors.teal
                    : const Color.fromRGBO(155, 162, 161, 1)),
          )
        ],
      ),
    );
  }
}
