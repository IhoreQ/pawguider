import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../styles.dart';

abstract class ImageGetter {

  static Future selectPhoto(BuildContext context, Function getImage, {Function? deleteFunction}) async {
    await showModalBottomSheet(useRootNavigator: true, context: context, builder: (context) => BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              getImage(ImageSource.camera);
              context.router.pop();
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
            child: ListTile(
              leading: const Icon(
                FluentSystemIcons.ic_fluent_camera_filled,
                size: 25.0,
                color: AppColor.lightText,
              ),
              title: Text('Camera', style: AppTextStyle.mediumLight),
            ),
          ),
          ListTile(
            leading: const Icon(
              FluentSystemIcons.ic_fluent_image_filled,
              size: 25.0,
              color: AppColor.lightText,
            ),
            title: Text('Pick a photo', style: AppTextStyle.mediumLight,),
            onTap: () {
              getImage(ImageSource.gallery);
              context.router.pop();
            },
          ),
          deleteFunction != null ?
            ListTile(
              leading: const Icon(
                FluentSystemIcons.ic_fluent_delete_filled,
                size: 25.0,
                color: AppColor.lightText,
              ),
              title: Text('Remove current picture', style: AppTextStyle.mediumLight),
              onTap: () {
                deleteFunction();
                context.router.pop();
              }
            ) : const SizedBox(),
        ],
      ), onClosing: () {},
    ));
  }

}