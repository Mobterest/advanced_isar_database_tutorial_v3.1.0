import 'package:expensetracker/util/func.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../collections/expense.dart';

part 'expense_provider.g.dart';

@riverpod
class ExpenseMain extends _$ExpenseMain with Func {
  @override
  Future<double> build() => getTotalExpenses().then((value) => value);
}

@riverpod
class ExpenseCount extends _$ExpenseCount with Func {
  @override
  Future<int> build() => expensesByCount().then((value) => value);
}

@riverpod
class ExpenseCategory extends _$ExpenseCategory with Func {
  @override
  Future<List<double>> build() => sumByCategory().then((value) => value);
}

@riverpod
class ExpenseFilter extends _$ExpenseFilter with Func {
  @override
  List<Expense> build() => [];

  clearState() {
    state = [];
  }

  void filterByCategory(CategoryEnum value) async {
    state = await expensesByCategory(value);
  }

  void filterByAmountRange(double low, double high) async {
    state = await expensesByAmountRange(low, high);
  }

  void filterByAmountGreaterThan(double amount) async {
    state = await expensesByAmountGreaterThan(amount);
  }

  void filterByAmountLessThan(double amount) async {
    state = await expensesByAmountLessThan(amount);
  }

  void filterByAmountAndCategory(
      CategoryEnum value, double amountHighValue) async {
    state = await expensesByCategoryAndAmount(value, amountHighValue);
  }

  void filterByNotOthersCategory() async {
    state = await expensesByNotOthersCategory();
  }

  void filterByGroupFilter(String searchText, DateTime dateTime) async {
    state = await expensesByGroupFilter(searchText, dateTime);
  }

  void filterByPaymentMethod(String searchText) async {
    state = await expensesByPaymentMethod(searchText);
  }

  void filterByUsingAny(List<CategoryEnum> categories) async {
    state = await expensesByUsingAny(categories);
  }

  void filterByUsingAll(List<CategoryEnum> categories) async {
    state = await expensesByUsingAll(categories);
  }

  void filterbyTags(int tags) async {
    state = await expensesByTags(tags);
  }

  void filterByTagName(String tagName) async {
    state = await expensesByTagName(tagName);
  }

  void filterBySubCategory(String subCategory) async {
    state = await expensesBySubCategory(subCategory);
  }

  void filterByReceipt(String receiptName) async {
    state = await expensesByReceipts(receiptName);
  }

  void filterByPagination(int offset) async {
    state = await expensesByPagination(offset);
  }

  void filterByFindingFirst() async {
    state = await expensesByFindFirst();
  }

  void filterByDeletingFirst() async {
    state = await expensesByDeleteFirst();
  }

  void filterByFullTextSearch(String searchText) async {
    state = await expensesByFullTextSearch(searchText);
  }

  void deleteExpense(Expense collection) async {
    state = await deleteItem(collection);
    ref.invalidateSelf();
  }
}
