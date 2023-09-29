import 'package:flutter/material.dart';
import 'package:front_flutter/providers/loading_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.3),
          backgroundColor: AppColor.primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size.fromHeight(50.0),
          maximumSize: const Size.fromHeight(50.0),
        ),
        onPressed: () => onPressed(),
        child: Consumer<LoadingProvider>(builder: (context, loadingProvider, _) {
          return loadingProvider.isLoading ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [Colors.white],
                strokeWidth: 2,
              )
          )
              : Text(
            label,
            style: AppTextStyle.semiBoldWhite,
          );
        }),
    );
  }
}
