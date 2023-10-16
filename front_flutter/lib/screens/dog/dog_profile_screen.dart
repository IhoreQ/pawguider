import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/behavior_box.dart';
import 'package:front_flutter/widgets/custom_vertical_divider.dart';
import 'package:front_flutter/widgets/two_elements_column.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/dog/dog.dart';
import '../../widgets/common_loading_indicator.dart';

@RoutePage()
class DogProfileScreen extends StatelessWidget {
  const DogProfileScreen({Key? key, @PathParam() required this.dogId, required this.onComplete})
      : super(key: key);

  final VoidCallback onComplete;
  final int dogId;

  @override
  Widget build(BuildContext context) {
    final DogService dogService = DogService();

    return Scaffold(
        body: FutureBuilder<Dog>(
          future: dogService.getDog(dogId),
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Dog dog = snapshot.data!;
            return Stack(fit: StackFit.expand, children: [
              Container(
                height: 1.0,
                color: AppColor.primaryOrange,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          TopBar(dog: dog, onComplete: onComplete, dogService: dogService),
                          DogContentPage(dog: dog),
                          DogAvatar(dog: dog),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]);
          }
          return const Center(
              child: SizedBox(
                  height: 48.0,
                  width: 48.0,
                  child: CommonLoadingIndicator(color: AppColor.primaryOrange)
              )
          );
        },
        )
    );
  }
}

class TopBar extends StatefulWidget {
  final Dog dog;
  final DogService dogService;
  final VoidCallback onComplete;

  const TopBar({Key? key, required this.dog, required this.onComplete, required this.dogService}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late bool _liked;

  @override
  void initState() {
    super.initState();
    _liked = widget.dog.likedByUser!;
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return widget.dog.ownerId == userProvider.user?.id
          ? Column(
              children: [
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => context.router.pop(),
                            icon: const Icon(
                              FluentSystemIcons.ic_fluent_arrow_left_regular,
                              size: iconSize,
                              color: Colors.white,
                            )),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: Icon(
                              FluentSystemIcons.ic_fluent_heart_filled,
                              size: iconSize,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(10.0),
                          SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => context.router
                                    .push(DogDetailsRoute(dog: widget.dog, onComplete: () => widget.onComplete())),
                                icon: const Icon(
                                  FluentSystemIcons.ic_fluent_edit_filled,
                                  size: iconSize,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0 + iconSize + 10.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          width: iconSize,
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.dog.likes}',
                            style: AppTextStyle.mediumWhite,
                          ))),
                ),
              ],
            )
          : Column(
              children: [
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => context.router.pop(),
                            icon: const Icon(
                              FluentSystemIcons.ic_fluent_arrow_left_regular,
                              size: iconSize,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                          width: iconSize,
                          height: iconSize,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: IconButton(
                                key: ValueKey<bool>(_liked),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => onLikeButtonClick(),
                                icon: _liked
                                    ? const Icon(
                                        FluentSystemIcons
                                            .ic_fluent_heart_filled,
                                        size: iconSize,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        FluentSystemIcons
                                            .ic_fluent_heart_regular,
                                        size: iconSize,
                                        color: Colors.white,
                                      )),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          width: iconSize,
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.dog.likes}',
                            style: AppTextStyle.mediumWhite,
                          ))),
                ),
              ],
            );
    });
  }

  Future<void> onLikeButtonClick() async {
    bool success = _liked ?
    await widget.dogService.deleteLike(widget.dog.id) :
    await widget.dogService.addLike(widget.dog.id);

    if (success) {
      if (_liked) {
        deleteLike();
      } else {
        addLike();
      }
    } else {
      print('error');
    }
  }

  void addLike() {
    widget.dog.addLike();
    _liked = !_liked;
    setState(() {});
  }

  void deleteLike() {
    widget.dog.subtractLike();
    _liked = !_liked;
    setState(() {});
  }
}

class DogContentPage extends StatelessWidget {
  final Dog dog;

  const DogContentPage({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    const double mainContainerMarginTop = 130.0;
    const double bottomBarHeight = 80.0;

    return Container(
      margin: const EdgeInsets.only(top: mainContainerMarginTop),
      width: deviceWidth,
      constraints: BoxConstraints(
        minHeight: deviceHeight - bottomBarHeight - mainContainerMarginTop,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(65.0),
            Center(
                child: Text(dog.name,
                    style: AppTextStyle.heading1.copyWith(fontSize: 25.0))),
            Center(
                child: Text(dog.breed!,
                    style: AppTextStyle.heading3.copyWith(fontSize: 18.0))),
            const Gap(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TwoElementsColumn(topText: 'Gender', bottomText: dog.gender),
                const CustomVerticalDivider(height: 20.0),
                TwoElementsColumn(topText: 'Age', bottomText: '${dog.age} yo.'),
                const CustomVerticalDivider(height: 20.0),
                TwoElementsColumn(topText: 'Size', bottomText: dog.size),
              ],
            ),
            const Gap(25.0),
            Text('Traits and behavior',
                style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
            const Gap(10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: dog.behaviors!
                  .map((behavior) => BehaviorBox(label: behavior.name))
                  .toList(),
            ),
            const Gap(25.0),
            Text('About dog',
                style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
            const Gap(10.0),
            Text(dog.description!,
                style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0)),
            const Gap(20.0),
          ],
        ),
      ),
    );
  }
}

class DogAvatar extends StatelessWidget {
  final Dog dog;

  const DogAvatar({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 65),
        child: PhysicalModel(
          color: Colors.black,
          shape: BoxShape.circle,
          elevation: 10.0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(dog.photoUrl),
            radius: 65.0,
          ),
        ),
      ),
    );
  }
}
