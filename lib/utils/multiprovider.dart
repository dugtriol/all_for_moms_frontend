import 'package:flutter/material.dart';
import 'provider_old.dart'; // Assuming your NotifierProvider is here

class MultiNotifierProvider extends StatelessWidget {
  final List<NotifierProvider> providers;
  final Widget child;

  const MultiNotifierProvider({
    Key? key,
    required this.providers,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;

    for (final provider in providers.reversed) {
      tree = provider.copyWith(child: tree);
    }

    return tree;
  }
}

extension on NotifierProvider {
  NotifierProvider copyWith({required Widget child}) {
    return NotifierProvider(
      key: key,
      model: model,
      child: child,
    );
  }
}
