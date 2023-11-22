// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseMainHash() => r'd47c1f0bdef99f34048ceff0b3eb8037bdbc60b5';

/// See also [ExpenseMain].
@ProviderFor(ExpenseMain)
final expenseMainProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseMain, double>.internal(
  ExpenseMain.new,
  name: r'expenseMainProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$expenseMainHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseMain = AutoDisposeAsyncNotifier<double>;
String _$expenseCountHash() => r'260e04210b49951469c3e5eb966eb2641d8de87d';

/// See also [ExpenseCount].
@ProviderFor(ExpenseCount)
final expenseCountProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseCount, int>.internal(
  ExpenseCount.new,
  name: r'expenseCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$expenseCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseCount = AutoDisposeAsyncNotifier<int>;
String _$expenseCategoryHash() => r'b05a889ac90061c540c3f94258f14b7ea0f19923';

/// See also [ExpenseCategory].
@ProviderFor(ExpenseCategory)
final expenseCategoryProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseCategory, List<double>>.internal(
  ExpenseCategory.new,
  name: r'expenseCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseCategory = AutoDisposeAsyncNotifier<List<double>>;
String _$expenseFilterHash() => r'fd9013c194cfb0baf2dade3644fb39b538c94e4a';

/// See also [ExpenseFilter].
@ProviderFor(ExpenseFilter)
final expenseFilterProvider =
    AutoDisposeNotifierProvider<ExpenseFilter, List<Expense>>.internal(
  ExpenseFilter.new,
  name: r'expenseFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseFilter = AutoDisposeNotifier<List<Expense>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
