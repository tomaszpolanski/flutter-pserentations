import 'package:flutter/material.dart';
import 'package:flutter_presentations/shared/stacked_page.dart';
import 'package:presentation/presentation.dart';

class FlutterContainer extends StatelessWidget {
  const FlutterContainer(
    this.controller, {
    Key? key,
  }) : super(key: key);
  final PresentationController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.headline5,
      child: StackedPage(
        controller: controller,
        children: const [
          Text('Padding'),
          Text('ConstrainedBox'),
          Text('Align'),
          Text('ColoredBox'),
          Text('Transform'),
        ],
      ),
    );
  }
}
