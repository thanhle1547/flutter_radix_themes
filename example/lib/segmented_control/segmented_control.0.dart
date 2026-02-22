import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSegmentedControl].

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

void main() => runApp(const SegmentedControlApp());

class SegmentedControlApp extends StatelessWidget {
  const SegmentedControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [RadixTheme.kExtensionFallbackLight],
      ),
      home: SegmentedControlExample(),
    );
  }
}

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({super.key});

  @override
  State<SegmentedControlExample> createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlExample> {
  Sky _selectedSegment = Sky.midnight;

  void _handleSegmentChanged(Sky? value) {
    if (value != null) {
      setState(() {
        _selectedSegment = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    final Map<Sky, Widget> controlChildren = const <Sky, Widget>{
      Sky.midnight: Text('Midnight'),
      Sky.viridian: Text('Viridian'),
      Sky.cerulean: Text('Cerulean'),
    };

    return Material(
      color: RadixColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            RadixSegmentedControl<Sky>(
              // This represents the currently selected segmented control.
              groupValue: _selectedSegment,
              // Callback that sets the selected segmented control.
              onValueChanged: _handleSegmentChanged,
              children: controlChildren,
            ),

            RadixSegmentedControl<Sky>(
              variant: RadixSegmentedControlVariant.classic,
              groupValue: _selectedSegment,
              onValueChanged: _handleSegmentChanged,
              cornerRadius: radixRadiusFactor.full.full,
              children: controlChildren,
            ),

            Text('Selected Segment: ${_selectedSegment.name}'),
          ],
        ),
      ),
    );
  }
}
