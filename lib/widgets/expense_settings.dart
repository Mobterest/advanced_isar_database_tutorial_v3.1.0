import 'package:currency_picker/currency_picker.dart';
import 'package:expensetracker/util/func.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key, required this.view});

  final Map<int, bool> view;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> with Func {
  bool faceId = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.view[4]!,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 18),
          ),
          SwitchListTile(
              activeColor: Colors.teal,
              title: const Text(
                "Use Face/Fingerprint ID",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              value: faceId,
              onChanged: (bool value) {
                setState(() {
                  faceId = value;
                });
              }),
          const Text("Currency"),
          ListTile(
            onTap: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showSearchField: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                favorite: ['eur'],
                onSelect: (Currency currency) {
                  //print('Select currency: ${currency.name}');
                },
              );
            },
            leading: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.teal),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "\$",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
            title: const Text(
              "US Dollars",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 50)),
                  onPressed: () {
                    clearData();
                    setState(() {});
                  },
                  child: const Text("Clear Data")),
            ),
          )
        ]));
  }
}
