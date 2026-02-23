import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSelect].

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
    final RadixInputDecorationThemeData decorationTheme = RadixSelectDecorationTheme.fromTheme(context);
    final RadixInputDecoration selectDecoration = RadixInputDecoration(
      hintText: 'Num',
    ).applyDefaults(decorationTheme);

    final OutlineInputBorder border = selectDecoration.enabledBorder! as OutlineInputBorder;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Container(
          height: selectDecoration.contentHeight,
          padding: selectDecoration.contentPadding,
          decoration: BoxDecoration(
            color: WidgetStateProperty.resolveAs(
              selectDecoration.backgroundColor,
              {},
            ),
            border: Border.fromBorderSide(
              border.borderSide,
            ),
            borderRadius: border.borderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: border.gapPadding),
              Text(
                dropdownValue,
                style: selectDecoration.textStyle,
              ),
              SizedBox(width: selectDecoration.inputToSuffixGap),
              CustomPaint(
                painter: _RadixChevronDownIconPainter(
                  color: WidgetStateProperty.resolveAs(
                    selectDecoration.suffixIconColor!,
                    {},
                  ),
                ),
                size: Size.square(selectDecoration.iconSize!),
              ),
            ],
          ),
        ),
        RadixSelect(
          initialValue: dropdownValue,
          options: list.map<RadixSelectItem<String>>((String value) {
            return RadixSelectItem<String>(value: value, child: Text(value));
          }).toList(),
          inputDecoration: selectDecoration,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      ],
    );
  }
}

class _RadixChevronDownIconPainter extends CustomPainter {
  _RadixChevronDownIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width*0.2090153,size.height*0.4105353);
    path.cubicTo(size.width*0.2216067,size.height*0.3971047,size.width*0.2427013,size.height*0.3964247,size.width*0.2561313,size.height*0.4090153);
    path.lineTo(size.width*0.5000000,size.height*0.6376427);
    path.lineTo(size.width*0.7438667,size.height*0.4090153);
    path.cubicTo(size.width*0.7573000,size.height*0.3964247,size.width*0.7783933,size.height*0.3971047,size.width*0.7909867,size.height*0.4105353);
    path.cubicTo(size.width*0.8035733,size.height*0.4239660,size.width*0.8028933,size.height*0.4450607,size.width*0.7894667,size.height*0.4576513);
    path.lineTo(size.width*0.5227980,size.height*0.7076533);
    path.cubicTo(size.width*0.5099760,size.height*0.7196733,size.width*0.4900240,size.height*0.7196733,size.width*0.4772020,size.height*0.7076533);
    path.lineTo(size.width*0.2105353,size.height*0.4576513);
    path.cubicTo(size.width*0.1971047,size.height*0.4450607,size.width*0.1964247,size.height*0.4239660,size.width*0.2090153,size.height*0.4105353);
    path.close();

    final Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RadixChevronDownIconPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}