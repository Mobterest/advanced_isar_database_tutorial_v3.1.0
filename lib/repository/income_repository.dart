import 'package:expensetracker/repository/adapter.dart';
import 'package:isar/isar.dart';

import '../collections/income.dart';
import '../main.dart';

class IncomeRepository extends Adapter<Income> {
  @override
  Future<void> createMultipleObjects(List<Income> collections) async {
    await isar.writeTxn(() async {
      await isar.incomes.putAll(collections);
    });
  }

  @override
  Future<void> createObject(Income collection) async {
    await isar.writeTxn(() async {
      await isar.incomes.put(collection);
    });
  }

  @override
  Future<void> deletObject(Income collection) async {
    await isar.writeTxn(() async {
      await isar.incomes.delete(collection.id);
    });
  }

  @override
  Future<void> deleteMultipleObjects(List<int> ids) async {
    await isar.incomes.deleteAll(ids);
  }

  @override
  Future<List<Income>> getAllObjects() async {
    return await isar.incomes.where().findAll();
  }

  @override
  Future<Income?> getObjectById(int id) async {
    return await isar.incomes.get(id);
  }

  @override
  Future<List<Income?>> getObjectsById(List<int> ids) async {
    return await isar.incomes.getAll(ids);
  }

  @override
  Future<void> updateObject(Income collection) async {
    await isar.writeTxn(() async {
      final budget = await isar.incomes.get(collection.id);

      if (budget != null) {
        await isar.incomes.put(collection);
      }
    });
  }
}
