import 'package:expensetracker/collections/receipt.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
@CustomSubCategoryConverter()
@collection
class Expense {
  Expense();

  Id id = Isar.autoIncrement;

  @Index()
  late double amount;

  @Index()
  late DateTime date;

  @Enumerated(EnumType.name)
  CategoryEnum? category;

  SubCategory? subcategory;

  final receipts = IsarLinks<Receipt>();

  @Index(composite: [CompositeIndex('amount')])
  String? paymentMethod;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String>? description;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

enum CategoryEnum { bills, food, clothes, transport, fun, others }

@embedded
class SubCategory {
  String? name;
}

class CustomSubCategoryConverter implements JsonConverter<SubCategory, String> {
  const CustomSubCategoryConverter();

  @override
  SubCategory fromJson(String json) {
    return SubCategory()..name = json;
  }

  @override
  String toJson(SubCategory object) => object.name!;
}
