import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/overlay_inkwell.dart';

import '../models/dog/dog.dart';

class WalkPartnerBox extends StatefulWidget {
  const WalkPartnerBox({super.key, required this.dog, required this.onSelected, this.selected});

  final Dog dog;
  final ValueChanged<bool> onSelected;
  final bool? selected;

  @override
  State<WalkPartnerBox> createState() => _WalkPartnerBoxState();
}

class _WalkPartnerBoxState extends State<WalkPartnerBox> {

  final double imageSize = 130.0;
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.selected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            AppShadow.photoShadow
          ]
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 130.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Image.network(
                    widget.dog.photoUrl,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.dog.name, style: AppTextStyle.semiBoldDark,),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          key: ValueKey<bool>(_isSelected),
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                              color: _isSelected ? AppColor.primaryOrange : AppColor.lightGray.withOpacity(0.5),
                              shape: BoxShape.circle
                          ),
                          child: _isSelected ? const Center(
                            child: Icon(
                              FluentSystemIcons.ic_fluent_checkmark_filled,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ) : null,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          OverlayInkwell(onTap: () {
            _isSelected = !_isSelected;
            setState(() {});
            widget.onSelected(_isSelected);
          })
        ],
      )
    );
  }
}
