import 'package:flutter/material.dart';
import 'package:front_flutter/widgets/common_loading_indicator.dart';

class SizedLoadingIndicator extends StatelessWidget {
  const SizedLoadingIndicator({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 48.0,
            width: 48.0,
            child: CommonLoadingIndicator(color: color)
        )
    );
  }
}
