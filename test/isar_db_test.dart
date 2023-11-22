import 'dart:io';

import 'package:expensetracker/collections/budget.dart';
import 'package:expensetracker/collections/expense.dart';
import 'package:expensetracker/collections/income.dart';
import 'package:expensetracker/collections/receipt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {
  late Isar isarTest;
  late Directory dirTest;

  setUp(() async {
    dirTest = Directory.systemTemp.createTempSync();
    await Isar.initializeIsarCore(download: true);

    if (Isar.instanceNames.isEmpty) {
      isarTest = await Isar.open(
          [BudgetSchema, ExpenseSchema, ReceiptSchema, IncomeSchema],
          directory: dirTest.path, name: 'expenseInstance');
    }
  });

  test("Open an instance on the Isar database", () async {
    final isOpen = isarTest.isOpen;
    expect(isOpen, true);
  });

  group("work with Budget collection", () {
    final budget = Budget()
      ..month = DateTime.now().month
      ..year = DateTime.now().year
      ..amount = 1000;

    test("create a Budget object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.budgets.put(budget);
      });

      final bdgt = await isarTest.budgets.get(budget.id);
      expect(bdgt?.id, budget.id);

      await isarTest.writeTxn(() async {
        await isarTest.budgets.clear();
      });
    });

    test("read Budget object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.budgets.put(budget);
      });

      final retrievedBudget = await isarTest.budgets.get(1);

      expect(retrievedBudget?.amount, 1000);
      expect(retrievedBudget?.id, 1);
    });

    test("update Budget object", () async {
      Budget? updatedBudget;

      await isarTest.writeTxn(() async {
        await isarTest.budgets.put(budget);
      });

      budget.amount = 2000;
      await isarTest.writeTxn(() async {
        await isarTest.budgets.put(budget);
      });

      await isarTest.writeTxn(() async {
        updatedBudget = await isarTest.budgets.get(1);
      });

      expect(updatedBudget?.amount, 2000);

      await isarTest.writeTxn(() async {
        await isarTest.budgets.clear();
      });
    });

    test("delete Budget object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.budgets.put(budget);
      });

      await isarTest.writeTxn(() async {
        await isarTest.budgets.delete(budget.id);
      });

      final deletedBudget =
          await isarTest.budgets.where().idEqualTo(1).findFirst();
      expect(deletedBudget, isNull);

      await isarTest.writeTxn(() async {
        await isarTest.budgets.clear();
      });
    });
  });

  tearDownAll(() async {
    await isarTest.close(deleteFromDisk: true);
  });
}
