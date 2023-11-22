import 'package:expensetracker/util/func.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'widgets/expense_gallery.dart';
import 'widgets/expense_home.dart';
import 'widgets/expense_screen.dart';
import 'widgets/expense_settings.dart';
import 'widgets/expense_statistics.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Func {
  int cIndex = 0;
  Map<int, bool> view = {
    0: true,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false
  };

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    backgroundWork(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              HomeWidget(
                view: view,
              ),
              ExpenseWidget(view: view, scrollController: scrollController),
              StatsWidget(
                view: view,
              ),
              Gallery(
                view: view,
              ),
              SettingsWidget(
                view: view,
              )
            ],
          ),
        )),
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: cIndex,
          onTap: (i) {
            setState(() {
              cIndex = i;
              view.forEach((key, value) => view[key] = false);
              view[i] = true;
            });
          },
          items: [
            createBottomBarItem(Icons.home, "Home"),
            createBottomBarItem(Icons.add, "Expense"),
            createBottomBarItem(Icons.show_chart, "Stats"),
            createBottomBarItem(Icons.photo_album, "Gallery"),
            createBottomBarItem(Icons.settings, "Settings")
          ]),
    );
  }

  SalomonBottomBarItem createBottomBarItem(IconData icon, String iconText) {
    return SalomonBottomBarItem(
        icon: Icon(icon), title: Text(iconText), selectedColor: Colors.teal);
  }
}
