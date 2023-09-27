import 'package:flutter/material.dart';

class OverlayInkwell extends StatelessWidget {
  const OverlayInkwell({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
