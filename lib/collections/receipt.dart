import 'package:isar/isar.dart';

import 'expense.dart';

part 'receipt.g.dart';

@collection
class Receipt {
  Id id = Isar.autoIncrement;

  late String name;

  @Backlink(to: 'receipts')
  final expense = IsarLink<Expense>();
}
