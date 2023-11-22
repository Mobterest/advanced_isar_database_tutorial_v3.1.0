import 'package:expensetracker/providers/expense/expense_provider.dart';
import 'package:expensetracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../collections/expense.dart';
import '../util/config.dart';
import 'expense_category_item.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterState();

  static const routeName = "/filter";
}

class _FilterState extends ConsumerState<Filter> {
  int selectedItem = 0;
  Amountfilter? groupValue;
  final TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final TextEditingController searchController = TextEditingController();
  List<int> selectedItems = [];
  int dropdownValue = 0;
  List<int> numberOfTags = [0, 2, 3, 5];
  int offset = 0;
  Orderfilter? insertionOrder;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FilterArguments;
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter by ${args.fb.name}",
                    style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.teal,
                      ))
                ],
              ),
              filterByCategory(args),
              filterByAmountRange(args, context, ref),
              filterByAmount(args),
              filterByCategoryAndAmount(args),
              filterByNotOthersCategory(args),
              filterByGroupFilter(args, context),
              filterByPaymentMethod(args),
              filterByAnySelectedCategory(args),
              filterByAllSelectedCategory(args),
              filterByTags(args, context),
              filterByTagName(args, context),
              filterBySubCategory(args, context),
              filterByReceipt(args, context),
              filterByPagination(args, context),
              filterByInsertion(args),
              const QueryResult()
            ],
          ),
        ),
      )),
    );
  }

  Visibility filterByInsertion(FilterArguments args) {
    return Visibility(
      visible: (args.fb == Filterby.insertion),
      child: Column(
        children: [
          RadioListTile<Orderfilter>(
              activeColor: Colors.teal,
              title: const Text("Find first"),
              value: Orderfilter.findfirst,
              groupValue: insertionOrder,
              onChanged: (Orderfilter? value) {
                setState(() {
                  insertionOrder = value!;
                });
                ref.read(expenseFilterProvider.notifier).filterByFindingFirst();
              }),
          RadioListTile<Orderfilter>(
              activeColor: Colors.teal,
              title: const Text("Delete first"),
              value: Orderfilter.deletefirst,
              groupValue: insertionOrder,
              onChanged: (Orderfilter? value) {
                setState(() {
                  insertionOrder = value!;
                });
                ref
                    .read(expenseFilterProvider.notifier)
                    .filterByDeletingFirst();
              }),
        ],
      ),
    );
  }

  Visibility filterByPagination(FilterArguments args, BuildContext context) {
    return Visibility(
        visible: (args.fb == Filterby.pagination),
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                ref
                    .read(expenseFilterProvider.notifier)
                    .filterByPagination(offset);
                setState(() {
                  offset += 3;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: const StadiumBorder(),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 30)),
              child: const Text("Display items (3 items)")),
        ));
  }

  Visibility filterByReceipt(FilterArguments args, BuildContext context) {
    return Visibility(
        visible: (args.fb == Filterby.receipt),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "Search Receipt name",
                    hintStyle: TextStyle(color: Colors.teal)),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    ref
                        .read(expenseFilterProvider.notifier)
                        .filterByReceipt(searchController.text);
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.teal,
                ))
          ],
        ));
  }

  Visibility filterBySubCategory(FilterArguments args, BuildContext context) {
    return Visibility(
        visible: (args.fb == Filterby.subcat),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "Search sub category",
                    hintStyle: TextStyle(color: Colors.teal)),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    ref
                        .read(expenseFilterProvider.notifier)
                        .filterBySubCategory(searchController.text);
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.teal,
                ))
          ],
        ));
  }

  Visibility filterByTagName(FilterArguments args, BuildContext context) {
    return Visibility(
        visible: (args.fb == Filterby.tagName),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "Search tag",
                    hintStyle: TextStyle(color: Colors.teal)),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    ref
                        .read(expenseFilterProvider.notifier)
                        .filterByTagName(searchController.text);
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.teal,
                ))
          ],
        ));
  }

  Visibility filterByTags(FilterArguments args, BuildContext context) {
    return Visibility(
      visible: (args.fb == Filterby.tags),
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Number of tags:"),
            const Spacer(),
            DropdownButton<int>(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              style: const TextStyle(color: Colors.teal),
              underline: Container(
                height: 2,
                color: Colors.teal,
              ),
              onChanged: (int? value) {
                setState(() {
                  dropdownValue = value!;
                });
                ref
                    .read(expenseFilterProvider.notifier)
                    .filterbyTags(dropdownValue);
              },
              items: numberOfTags.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Visibility filterByAllSelectedCategory(FilterArguments args) {
    return Visibility(
        visible: (args.fb == Filterby.allSelectedCategory),
        child: Column(children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 4.0),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (selectedItems.contains(index)) {
                        selectedItems.remove(index);
                      } else {
                        selectedItems.add(index);
                      }
                    });
                  },
                  child: Card(
                    color: selectedItems.contains(index)
                        ? const Color(0xFFA4D6D1)
                        : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/${categories[index]["icon"]!}",
                          width: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            categories[index]["name"]!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedItems.contains(index)
                                    ? Colors.teal
                                    : const Color.fromRGBO(155, 162, 161, 1),
                                fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                    });
                    ref.read(expenseFilterProvider.notifier).clearState();
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.teal,
                      side: const BorderSide(color: Colors.teal),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.3, 30)),
                  child: const Text("Reset"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      List<CategoryEnum> categories = [];
                      for (int selectedItem in selectedItems) {
                        categories.add(CategoryEnum.values[selectedItem]);
                      }

                      ref
                          .read(expenseFilterProvider.notifier)
                          .filterByUsingAll(categories);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: const StadiumBorder(),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 30)),
                    child: const Text("Apply"))
              ]))
        ]));
  }

  Visibility filterByAnySelectedCategory(FilterArguments args) {
    return Visibility(
        visible: (args.fb == Filterby.anySelectedCategory),
        child: Column(children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 4.0),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (selectedItems.contains(index)) {
                        selectedItems.remove(index);
                      } else {
                        selectedItems.add(index);
                      }
                    });
                  },
                  child: Card(
                    color: selectedItems.contains(index)
                        ? const Color(0xFFA4D6D1)
                        : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/${categories[index]["icon"]!}",
                          width: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            categories[index]["name"]!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedItems.contains(index)
                                    ? Colors.teal
                                    : const Color.fromRGBO(155, 162, 161, 1),
                                fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                    });
                    ref.read(expenseFilterProvider.notifier).clearState();
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.teal,
                      side: const BorderSide(color: Colors.teal),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.3, 30)),
                  child: const Text("Reset"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      List<CategoryEnum> categories = [];
                      for (int selectedItem in selectedItems) {
                        categories.add(CategoryEnum.values[selectedItem]);
                      }

                      ref
                          .read(expenseFilterProvider.notifier)
                          .filterByUsingAny(categories);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: const StadiumBorder(),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 30)),
                    child: const Text("Apply"))
              ]))
        ]));
  }

  Visibility filterByPaymentMethod(FilterArguments args) {
    return Visibility(
        visible: (args.fb == Filterby.paymentMethod),
        child: TextField(
          controller: searchController,
          onChanged: (String? value) {
            if (value == null) {
              ref.read(expenseFilterProvider.notifier).clearState();
            } else {
              ref
                  .read(expenseFilterProvider.notifier)
                  .filterByPaymentMethod(value);
            }
          },
        ));
  }

  Visibility filterByGroupFilter(FilterArguments args, BuildContext context) {
    return Visibility(
        visible: (args.fb == Filterby.groupFilter),
        child: Column(
          children: [
            const Text("Category: Others"),
            ListTile(
                subtitle: Text(DateFormat("d MMM yyyy").format(selectedDate)),
                trailing: IconButton(
                    onPressed: () async {
                      selectedDate = (await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2030))) ??
                          DateTime.now();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.teal,
                    ))),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: "Search text",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.teal)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        selectedDate = DateTime.now();
                        searchController.clear();
                        ref.read(expenseFilterProvider.notifier).clearState();
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.3, 30)),
                      child: const Text("Reset")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          ref
                              .read(expenseFilterProvider.notifier)
                              .filterByGroupFilter(
                                  searchController.text, selectedDate);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: const StadiumBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.3, 30)),
                      child: const Text("Apply"))
                ],
              ),
            ),
          ],
        ));
  }

  Visibility filterByNotOthersCategory(FilterArguments args) {
    return Visibility(
      visible: (args.fb == Filterby.notOthers),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  ref.read(expenseFilterProvider.notifier).clearState();
                },
                style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    foregroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 30)),
                child: const Text("Reset")),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(expenseFilterProvider.notifier)
                      .filterByNotOthersCategory();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: const StadiumBorder(),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 30)),
                child: const Text("Apply"))
          ],
        ),
      ),
    );
  }

  Visibility filterByCategoryAndAmount(FilterArguments args) {
    return Visibility(
      visible: (args.fb == Filterby.categoryAndAmount),
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                  },
                  child: ExpenseCategoryItem(
                    index: index,
                    selectedItem: selectedItem,
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(
                  hintText: "Amount greater than ...",
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      amountController.clear();
                      ref.read(expenseFilterProvider.notifier).clearState();
                    },
                    style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.teal,
                        side: const BorderSide(color: Colors.teal),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 30)),
                    child: const Text("Reset")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (amountController.text.isNotEmpty) {
                        ref
                            .read(expenseFilterProvider.notifier)
                            .filterByAmountAndCategory(
                                CategoryEnum.values[selectedItem],
                                double.parse(amountController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: const StadiumBorder(),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 30)),
                    child: const Text("Apply"))
              ],
            ),
          )
        ],
      ),
    );
  }

  Visibility filterByAmount(FilterArguments args) {
    final TextEditingController amountController = TextEditingController();

    return Visibility(
        visible: (args.fb == Filterby.amount),
        child: Column(
          children: [
            RadioListTile<Amountfilter>(
                activeColor: Colors.teal,
                title: const Text("Greater than"),
                value: Amountfilter.greaterThan,
                groupValue: groupValue,
                onChanged: (Amountfilter? value) {
                  setState(() {
                    groupValue = value!;
                  });
                }),
            RadioListTile<Amountfilter>(
                activeColor: Colors.teal,
                title: const Text("Less than"),
                value: Amountfilter.lessThan,
                groupValue: groupValue,
                onChanged: (Amountfilter? value) {
                  setState(() {
                    groupValue = value!;
                  });
                }),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Enter amount'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        amountController.clear();
                        ref.read(expenseFilterProvider.notifier).clearState();
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.3, 30)),
                      child: const Text("Reset")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (amountController.text.isNotEmpty) {
                          if (groupValue == Amountfilter.greaterThan) {
                            ref
                                .read(expenseFilterProvider.notifier)
                                .filterByAmountGreaterThan(
                                    double.parse(amountController.text));
                          } else if (groupValue == Amountfilter.lessThan) {
                            ref
                                .read(expenseFilterProvider.notifier)
                                .filterByAmountLessThan(
                                    double.parse(amountController.text));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: const StadiumBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.3, 30)),
                      child: const Text("Apply"))
                ],
              ),
            )
          ],
        ));
  }

  Visibility filterByCategory(FilterArguments args) {
    return Visibility(
      visible: (args.fb == Filterby.category),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedItem = index;
                });

                ref
                    .read(expenseFilterProvider.notifier)
                    .filterByCategory(CategoryEnum.values[index]);
              },
              child: ExpenseCategoryItem(
                index: index,
                selectedItem: selectedItem,
              ),
            );
          }),
    );
  }
}

Visibility filterByAmountRange(
    FilterArguments args, BuildContext context, WidgetRef ref) {
  final filterformKey = GlobalKey<FormState>();
  final TextEditingController lowValueController = TextEditingController();
  final TextEditingController highValueController = TextEditingController();

  return Visibility(
    visible: (args.fb == Filterby.amountrange),
    child: Column(
      children: [
        Form(
          key: filterformKey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: lowValueController,
                  decoration: const InputDecoration(hintText: "Low value"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter low amount';
                    }
                    return null;
                  },
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: highValueController,
                  decoration: const InputDecoration(hintText: "High value"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter high amount';
                    }
                    return null;
                  },
                ))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    lowValueController.clear();
                    highValueController.clear();
                    ref.read(expenseFilterProvider.notifier).clearState();
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.teal,
                      side: const BorderSide(color: Colors.teal),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.3, 30)),
                  child: const Text("Reset")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (filterformKey.currentState!.validate()) {
                      ref
                          .read(expenseFilterProvider.notifier)
                          .filterByAmountRange(
                              double.parse(lowValueController.text),
                              double.parse(highValueController.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: const StadiumBorder(),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.3, 30)),
                  child: const Text("Apply"))
            ],
          ),
        )
      ],
    ),
  );
}

class QueryResult extends StatelessWidget {
  const QueryResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text(
            "Results",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ExpenseListWidget(filter: true, all: true)
      ],
    );
  }
}

class FilterArguments {
  final Filterby fb;

  FilterArguments({required this.fb});
}
