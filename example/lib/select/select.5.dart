import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSelect].

final List<String> list = <String>[
  'This is a very long option text that should wrap onto a new line when displayed in the popup',
  'Another option with an even longer description that continues far enough to demonstrate how the maxItemHeight property will constrain the layout of the select options',
  'Yet another lengthy option string that exceeds the typical width and forces the text to break into multiple lines for testing purposes',
  'Short',
];

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

  /// This is called when the user selects an item.
  void _handleChanged(String? value) {
    setState(() {
      dropdownValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<RadixSelectItem<String>> options = list.map<RadixSelectItem<String>>((String value) {
      return RadixSelectItem<String>(value: value, child: Text(value));
    }).toList();
    final List<RadixSelectItem<String>> oneLineOptions = list.map<RadixSelectItem<String>>((String value) {
      return RadixSelectItem<String>(
        value: value,
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList();
    final List<RadixSelectItem<String>> paddedOptions = list.map<RadixSelectItem<String>>((String value) {
      return RadixSelectItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6
          ),
          child: Text(value),
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          // When maxLines is not specified
          // and overflow is not TextOverflow.ellipsis,
          // the text will wrap onto multiple lines as needed,
          // up to the height allowed by its constraints.
          RadixSelect(
            initialValue: dropdownValue,
            options: options,
            isExpanded: true,
            tightHeight: true, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            textOverflow: TextOverflow.clip,
            maxItemHeight: 200,
            onChanged: _handleChanged,
          ),
          RadixSelect(
            initialValue: dropdownValue,
            options: options,
            isExpanded: true,
            tightHeight: false, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            textOverflow: TextOverflow.clip,
            maxItemHeight: 200,
            onChanged: _handleChanged,
          ),

          // Renders as a single line with ellipsis
          // if both the container (RadixSelect)
          // and the child text (RadixSelect.options)
          // constraints are set to maxLines: 1 and TextOverflow.ellipsis.
          RadixSelect(
            initialValue: dropdownValue,
            options: oneLineOptions,
            isExpanded: true,
            tightHeight: true, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            maxItemHeight: 200, // won't affect
            textOverflow: TextOverflow.ellipsis,
            textMaxLines: 1, // <-
            onChanged: _handleChanged,
          ),
          RadixSelect(
            initialValue: dropdownValue,
            options: oneLineOptions,
            isExpanded: true,
            tightHeight: false, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            maxItemHeight: 200, // won't affect
            textOverflow: TextOverflow.ellipsis,
            textMaxLines: 1, // <-
            onChanged: _handleChanged,
          ),

          RadixSelect(
            initialValue: dropdownValue,
            options: options,
            isExpanded: true,
            tightHeight: true, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            maxItemHeight: 200,
            textOverflow: TextOverflow.ellipsis,
            textMaxLines: 2, // <-
            onChanged: _handleChanged,
          ),
          RadixSelect(
            initialValue: dropdownValue,
            options: options,
            isExpanded: true,
            tightHeight: false, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            maxItemHeight: 200,
            textOverflow: TextOverflow.ellipsis,
            textMaxLines: 2, // <-
            onChanged: _handleChanged,
          ),

          RadixSelect(
            initialValue: dropdownValue,
            options: paddedOptions,
            isExpanded: true,
            tightHeight: false, // <-
            inputDecoration: RadixInputDecoration(
              hintText: 'Select one item',
            ),
            textOverflow: TextOverflow.clip,
            maxItemHeight: 200,
            onChanged: _handleChanged,
          ),
        ],
      ),
    );
  }
}