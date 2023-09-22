import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/behavior_box.dart';
import 'package:front_flutter/widgets/custom_vertical_divider.dart';
import 'package:front_flutter/widgets/two_elements_column.dart';
import 'package:gap/gap.dart';

import '../../models/behavior.dart';
import '../../models/dog/dog.dart';

@RoutePage()
class DogProfileScreen extends StatefulWidget {
  DogProfileScreen(
      {Key? key, @PathParam() required this.dogId})
      : super(key: key);

  final String dogId;

  @override
  State<DogProfileScreen> createState() => _DogProfileScreenState();
}

class _DogProfileScreenState extends State<DogProfileScreen> {

  late final Dog dog;

  @override
  void initState() {
    final List<Behavior> exampleBehaviors = [Behavior(1, 'Friendly'), Behavior(6, 'Calm'), Behavior(12, 'Curious'), Behavior(10, 'Independent')];
    Dog exampleDog = Dog('12', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG', 'Small', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.', 5, exampleBehaviors, 10);
    Dog exampleDog2 = Dog('13', 'Binia', 'Mongrel', false, 2, 'https://www.pedigree.pl/cdn-cgi/image/width=520,format=auto,q=90/sites/g/files/fnmzdf4096/files/2023-01/jack-russell-terrier_1640009953951.png', 'Small', '', 10, exampleBehaviors, 11);
    List<Dog> dogs = [exampleDog, exampleDog2];

    dog = dogs.firstWhere((element) => element.id == widget.dogId);

    super.initState();
  }

  // TODO wywalić parametr 'dog' i zamiast tego pobierać z bazy
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
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
                    TopBar(dog: dog),
                    DogContentPage(dog: dog),
                    DogAvatar(dog: dog),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class TopBar extends StatefulWidget {
  final Dog dog;

  const TopBar({Key? key, required this.dog}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final int userId = 10;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return widget.dog.ownerId == userId
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
                              onPressed: () => context.router.push(DogDetailsRoute(dog: widget.dog)),
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
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => {},
                          icon: const Icon(
                            FluentSystemIcons.ic_fluent_heart_regular,
                            size: iconSize,
                            color: Colors.white,
                          )),
                    )
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
                child: Text(dog.breed,
                    style: AppTextStyle.heading3.copyWith(fontSize: 18.0))),
            const Gap(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TwoElementsColumn(
                    topText: 'Gender',
                    bottomText: dog.gender ? 'Male' : 'Female'),
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
              children: dog.behaviors
                  .map((behavior) => BehaviorBox(label: behavior.name))
                  .toList(),
            ),
            const Gap(25.0),
            Text('About dog',
                style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
            Text(dog.description,
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
