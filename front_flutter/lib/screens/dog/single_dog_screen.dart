import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

@RoutePage()
class SingleDogScreen extends StatelessWidget {
  const SingleDogScreen({
    Key? key,
    @PathParam() required this.dogId
  }) : super(key: key);

  final String dogId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doggo"),
        titleTextStyle: AppTextStyle.appBarTitleHeading,
        titleSpacing: 0.0,
      ),
      body: Column(
        children: [
          Text("Piesek"),
        ],
      ),
    );
  }
}
