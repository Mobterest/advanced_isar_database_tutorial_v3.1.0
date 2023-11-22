import 'package:flutter/material.dart';

class ExpenseDivider extends StatelessWidget {
  const ExpenseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Divider(
        thickness: 1.0,
        indent: 20,
        endIndent: 20,
      ),
    );
  }
}
