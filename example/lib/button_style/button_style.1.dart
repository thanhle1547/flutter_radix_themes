import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixButton].

void main() {
  runApp(const ButtonApp());
}

class ButtonApp extends StatelessWidget {
  const ButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
        iconTheme: IconThemeData(
          size: 16,
        ),
      ),
      title: 'Icon Button Variants',
      home: const Scaffold(body: ButtonTypesExample()),
    );
  }
}

class ButtonTypesExample extends StatelessWidget {
  const ButtonTypesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Spacer(),
          ButtonTypesGroup(enabled: true),
          ButtonTypesGroup(enabled: false),
          ButtonTypesGroup(enabled: false, showLoading: true),
          Spacer(),
        ],
      ),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({
    super.key,
    required this.enabled,
    this.showLoading = false,
  });

  final bool enabled;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RadixSolidButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            disabled: !enabled,
            loading: showLoading,
            cacheLoadingState: showLoading,
          ),
          RadixSoftButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            disabled: !enabled,
            loading: showLoading,
            cacheLoadingState: showLoading,
          ),
          RadixSurfaceButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            disabled: !enabled,
            loading: showLoading,
            cacheLoadingState: showLoading,
          ),
          RadixOutlineButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            disabled: !enabled,
            loading: showLoading,
            cacheLoadingState: showLoading,
          ),
          RadixGhostButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            disabled: !enabled,
            loading: showLoading,
            cacheLoadingState: showLoading,
          ),
        ],
      ),
    );
  }
}