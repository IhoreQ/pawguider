import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CommonLoadingIndicator extends StatelessWidget {
  final Color color;
  const CommonLoadingIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      indicatorType: Indicator.circleStrokeSpin,
      colors: [color],
      strokeWidth: 2,
    );
  }
}
