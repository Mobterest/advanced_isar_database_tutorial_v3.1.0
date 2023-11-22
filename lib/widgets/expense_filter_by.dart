import 'package:expensetracker/widgets/expense_filter.dart';
import 'package:flutter/material.dart';

import '../util/config.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({super.key});

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter by",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.teal,
                      ))
                ],
              ),
              Column(children: buildWidget())
            ],
          ),
        ),
      )),
    );
  }

  List<Widget> buildWidget() {
    List<Widget> options = [];

    for (int i = 0; i < filterOptions.length; i++) {
      options.add(Card(
        child: ListTile(
          title: Text(filterOptions[i]),
          onTap: () {
            Navigator.pushNamed(context, Filter.routeName,
                arguments: FilterArguments(fb: Filterby.values[i]));
          },
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.teal,
          ),
        ),
      ));
    }
    return options;
  }
}
