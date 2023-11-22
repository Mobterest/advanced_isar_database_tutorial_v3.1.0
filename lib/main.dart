import 'package:expensetracker/collections/budget.dart';
import 'package:expensetracker/collections/expense.dart';
import 'package:expensetracker/collections/income.dart';
import 'package:expensetracker/collections/receipt.dart';
import 'package:expensetracker/util/func.dart';
import 'package:expensetracker/widgets/expense_detail.dart';
import 'package:expensetracker/widgets/expense_filter.dart';
import 'package:expensetracker/widgets/expense_filter_by.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';
import 'widgets/expense_search.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  if (Isar.instanceNames.isEmpty) {
    isar = await Isar.open(
        [BudgetSchema, ExpenseSchema, ReceiptSchema, IncomeSchema],
        directory: dir.path, name: 'expenseInstance');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget   {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: GoogleFonts.poppins().fontFamily)),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        ExpenseDetail.routeName: (context) => const ExpenseDetail(),
        "/filterby": (context) => const FilterBy(),
        Filter.routeName: (context) => const Filter(),
        "/search": (context) => const Search()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
