const List<Map<String, dynamic>> categories = [
  {"name": "Bills", "icon": "bill.png", "selected": false},
  {"name": "Food", "icon": "food.png", "selected": false},
  {"name": "Clothes", "icon": "clothes.png", "selected": false},
  {"name": "Transport", "icon": "transport.png", "selected": false},
  {"name": "Fun", "icon": "fun.png", "selected": false},
  {"name": "Others", "icon": "others.png", "selected": false}
];

//List<String> paymentMethods = ["Cash", "Credit card", "Bank account"];

List<String> filterOptions = [
  "Category",
  "Amount Range",
  "Amount",
  "Category and Amount",
  "Not Others Category",
  "Group Filter",
  "Payment Method",
  "Any Selected Category",
  "All Selected Category",
  "Tags",
  "Tag Name",
  "Sub Category",
  "Receipt",
  "Pagination",
  "Insertion"
];

enum Filterby {
  category,
  amountrange,
  amount,
  categoryAndAmount,
  notOthers,
  groupFilter,
  paymentMethod,
  anySelectedCategory,
  allSelectedCategory,
  tags,
  tagName,
  subcat,
  receipt,
  pagination,
  insertion
}

enum Amountfilter { greaterThan, lessThan }

enum Orderfilter { findfirst, deletefirst }