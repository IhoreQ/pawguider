import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class RoutingCircleAddButton extends StatelessWidget {
  const RoutingCircleAddButton({Key? key, required this.route}) : super(key: key);

  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10.0),
        backgroundColor: AppColor.primaryOrange,
      ),
      child: const Icon(
        Icons.add,
        size: 30,
        color: AppColor.orangeAccent,
      ),
      onPressed: () => context.router.push(route),
    );
  }
}
