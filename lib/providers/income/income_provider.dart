import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../collections/income.dart';
import '../../util/func.dart';

part 'income_provider.g.dart';

@riverpod
class ExpenseIncome extends _$ExpenseIncome with Func {
  @override
  Future<List<Income>> build() => getAllIncomes().then(((value) => value));
}
