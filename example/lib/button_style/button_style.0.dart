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
      ),
      title: 'Button Variants',
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
          ButtonTypesGroup(enabled: false, showLoading: false, standaloneSpinner: true),
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
    this.standaloneSpinner = false,
  });

  final bool enabled;
  final bool showLoading;

  /// Whether to maintain the text of the [RadixButton] when it is
  /// in loading state.
  final bool standaloneSpinner;

  @override
  Widget build(BuildContext context) {
    const Widget loadingSpinner = RadixSpinner();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RadixSolidButton(
            disabled: !enabled,
            iconStart: standaloneSpinner ? loadingSpinner : null,
            loading: showLoading,
            cacheLoadingState: showLoading,
            text: 'Solid',
          ),
          RadixSoftButton(
            disabled: !enabled,
            iconStart: standaloneSpinner ? loadingSpinner : null,
            loading: showLoading,
            cacheLoadingState: showLoading,
            text: 'Soft',
          ),
          RadixSurfaceButton(
            disabled: !enabled,
            iconStart: standaloneSpinner ? loadingSpinner : null,
            loading: showLoading,
            cacheLoadingState: showLoading,
            text: 'Surface',
          ),
          RadixOutlineButton(
            disabled: !enabled,
            iconStart: standaloneSpinner ? loadingSpinner : null,
            loading: showLoading,
            cacheLoadingState: showLoading,
            text: 'Outline',
          ),
          RadixGhostButton(
            disabled: !enabled,
            iconStart: standaloneSpinner ? loadingSpinner : null,
            loading: showLoading,
            cacheLoadingState: showLoading,
            text: 'Ghost',
          ),
        ],
      ),
    );
  }
}