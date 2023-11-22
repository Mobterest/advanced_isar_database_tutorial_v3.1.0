import 'package:expensetracker/util/func.dart';
import 'package:expensetracker/widgets/expense_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.view});

  final Map<int, bool> view;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with Func {
  bool loading = false;
  String? path;

  @override
  Widget build(BuildContext context) {
    getPath().then((value) {
      setState(() {
        path = value;
      });
    });

    return Visibility(
        visible: widget.view[3]!,
        child: FutureBuilder(
            future: getAllReceipts(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const ExpenseEmptyWidget(
                      subtitle: "No Receipts to display");
                } else {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.teal,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              loading = true;
                              clearGallery(snapshot.data!);
                              loading = false;
                            });
                          },
                        ),
                      ),
                      Visibility(
                          visible: loading,
                          child: const CircularProgressIndicator()),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisSpacing: 4.0),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: InstaImageViewer(
                                    child: Card(
                                      child: Image.asset(
                                        "$path/${snapshot.data![index].name}",
                                        width: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(fontSize: 11),
                                )
                              ],
                            );
                          })
                    ],
                  );
                }
              } else {
                return const ExpenseEmptyWidget(
                    subtitle: "No Receipts to display");
              }
            })));
  }
}
