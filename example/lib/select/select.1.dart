import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [DropdownButton].

final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const SelectApp());

class SelectApp extends StatelessWidget {
  const SelectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('RadixSelect Sample')),
        body: const Center(child: SelectExample()),
      ),
    );
  }
}

class SelectExample extends StatefulWidget {
  const SelectExample({super.key});

  @override
  State<SelectExample> createState() => _SelectExampleState();
}

class _SelectExampleState extends State<SelectExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return RadixSelect(
      // value: dropdownValue,
      options: list.map<RadixSelectItem<String>>((String value) {
        return RadixSelectItem<String>(value: value, child: Text(value));
      }).toList(),
      inputDecoration: RadixInputDecoration(
        hintText: 'aj ja',
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }
}