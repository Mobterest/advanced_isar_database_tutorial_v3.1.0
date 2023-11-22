import 'dart:io';

import 'package:expensetracker/collections/budget.dart';
import 'package:expensetracker/collections/expense.dart';
import 'package:expensetracker/repository/budget_repository.dart';
import 'package:expensetracker/repository/expense_repository.dart';
import 'package:expensetracker/repository/income_repository.dart';
import 'package:expensetracker/repository/receipt_repository.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../collections/income.dart';
import '../collections/receipt.dart';
import '../main.dart';
import '../widgets/expense_detail.dart';

mixin Func {
  Future<Budget?> createBudget(double amount) async {
    final budget = Budget()
      ..month = DateTime.now().month
      ..year = DateTime.now().year
      ..amount = amount;

    return await BudgetRepository().createObject(budget);
  }

  Future<Budget?> getBudget({required int month, required int year}) async {
    return await BudgetRepository()
        .getObjectByDate(month: month, year: year)
        .then((value) => value);
  }

  Future<Budget?> updateBudget(Budget budget) async {
    return await BudgetRepository().updateObject(budget);
  }

  Future<void> createExpense(
      double amount,
      DateTime date,
      CategoryEnum cenum,
      String subcat,
      Set<Receipt> receipts,
      List<String> description,
      String paymentMethod) async {
    final subcategory = SubCategory()..name = subcat;

    final formattedDate = date.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    for (Receipt receipt in receipts) {
      await ReceiptRepository().createObject(receipt);
    }

    Expense expense = Expense()
      ..amount = amount
      ..date = formattedDate
      ..category = cenum
      ..subcategory = subcategory
      ..description = description
      ..paymentMethod = paymentMethod
      ..receipts.addAll(receipts);

    return await ExpenseRepository().createObject(expense);
  }

  Future<List<Expense>> getTodaysExpenses() async {
    return await ExpenseRepository().getObjectsByToday().then((value) => value);
  }

  Future<List<Expense>> getAllExpenses() async {
    return await ExpenseRepository().getAllObjects().then((value) => value);
  }

  Future<String> getPath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  Future<List<Receipt>> getAllReceipts() async {
    return await ReceiptRepository().getAllObjects();
  }

  Future<List<Income>> getAllIncomes() async {
    return await IncomeRepository().getAllObjects();
  }

  clearData() async {
    await ExpenseRepository().clearData();
  }

  Future<double> getTotalExpenses() async {
    return await ExpenseRepository().totalExpenses();
  }

  Future<List<double>> sumByCategory() async {
    List<double> total = [];
    for (var value in CategoryEnum.values) {
      double sum = await ExpenseRepository().getSumForCategory(value);
      total.add(sum);
    }
    return total;
  }

  Future<List<Expense>> expensesByCategory(CategoryEnum value) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByCategory(value).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountRange(double low, double high) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByAmountRange(low, high).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountGreaterThan(double amount) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsWithAmountGreaterThan(amount)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountLessThan(double amount) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsWithAmountLessThan(amount)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByCategoryAndAmount(
      CategoryEnum value, double amountHighValue) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsByOptions(value, amountHighValue)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByNotOthersCategory() async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsNotOthersCategory().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByGroupFilter(
      String searchText, DateTime dateTime) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsByGroupFilter(searchText, dateTime)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByPaymentMethod(String searchText) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsBySearchText(searchText).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByUsingAny(
      List<CategoryEnum> categories) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsUsingAnyOf(categories).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByUsingAll(
      List<CategoryEnum> categories) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsUsingAllOf(categories).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByTags(int tags) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsWithTags(tags).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByTagName(String tagName) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsWithTagName(tagName).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesBySubCategory(String subCategory) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsBySubCategory(subCategory)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByReceipts(String receiptName) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByReceipts(receiptName).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByPagination(int offset) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsAndPaginate(offset).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByFindFirst() async {
    List<Expense> expenses = [];

    await ExpenseRepository().getOnlyFirstObject().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByDeleteFirst() async {
    List<Expense> expenses = [];

    await ExpenseRepository().deleteOnlyFirstObject().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<int> expensesByCount() async {
    return await ExpenseRepository().getTotalObjects();
  }

  Future<List<Expense>> expensesByFullTextSearch(String searchText) async {
    List<Expense> expenses = [];

    await ExpenseRepository().fullTextSearch(searchText).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> deleteItem(Expense collection) async {
    List<Expense> expenses = [];

    await ExpenseRepository().deletObject(collection).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<void> clearGallery(List<Receipt> receipts) async {
    await ReceiptRepository().clearGallery(receipts);
  }

  Future<Map<String, dynamic>> setConfigs(ExpenseDetailArguments args) async {
    String path = await getPath().then((value) => value);
    int count = await args.expense.receipts.count();

    return {"path": path, "count": count};
  }

  setWatcher(BuildContext context) {
    Stream<List<Expense>> expenseChanged = isar.expenses
        .filter()
        .dateEqualTo(DateTime.now().copyWith(
            hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))
        .watch(fireImmediately: true);

    expenseChanged.listen((event) {
      if (event.length > 7) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You have too many expenses for Today")));
      }
    });
  }

  Future<void> importDataFromFirebase() async {
    List<Income> incomes = [];

    if (!Firestore.initialized) {
      Firestore.initialize("isardatabase-723ab");
    }

    await Firestore.instance
        .collection('expensetracker')
        .get()
        .then((event) async {
      await isar.writeTxn(() async {
        await isar.incomes.clear();
      });

      for (final doc in event) {
        final income = Income()..name = doc.map["name"];
        incomes.add(income);
      }
    });

    await IncomeRepository().createMultipleObjects(incomes);
  }

  Future<void> exportDataToFirebase() async {
    if (!Firestore.initialized) {
      Firestore.initialize("isardatabase-723ab");
    }

    List<Expense> xpenses = await getAllExpenses();

    await Firestore.instance.collection('expenses').get().then((expenses) {
      for (Document expense in expenses) {
        expense.reference.delete();
      }
    });

    for (Expense expense in xpenses) {
      await Firestore.instance.collection('expenses').add(expense.toJson());
    }
  }

  void backgroundWork(BuildContext context) {
    setWatcher(context);
    importDataFromFirebase();
  }
}
