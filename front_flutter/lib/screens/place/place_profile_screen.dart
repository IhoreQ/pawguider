import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/main.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:gap/gap.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';


import '../../models/behavior.dart';
import '../../models/place.dart';
import '../../styles.dart';

@RoutePage()
class PlaceProfileScreen extends StatefulWidget {
  const PlaceProfileScreen({super.key, @PathParam() required this.placeId});

  final int placeId;

  @override
  State<PlaceProfileScreen> createState() => _PlaceProfileScreenState();
}

class _PlaceProfileScreenState extends State<PlaceProfileScreen> {

  late Place place;
  late List<Dog> dogs;

  @override
  void initState() {
    super.initState();

    final List<Behavior> exampleBehaviors = [Behavior(1, 'Friendly'), Behavior(6, 'Calm'), Behavior(12, 'Curious'), Behavior(10, 'Independent')];
    final Dog exampleDog = Dog('12', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG', 'Small', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.', 5, exampleBehaviors, 10);
    final Dog exampleDog2 = Dog('13', 'Binia', 'Mongrel', false, 2, 'https://www.pedigree.pl/cdn-cgi/image/width=520,format=auto,q=90/sites/g/files/fnmzdf4096/files/2023-01/jack-russell-terrier_1640009953951.png', 'Small', '', 10, exampleBehaviors, 11);

    dogs = [exampleDog, exampleDog2];
    place = Place(1, 'Kleparski wybieg', 'Park kleparski', '30-002', 'Kraków', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est.', 2, 5.0, 'https://lh6.googleusercontent.com/UdJXDyQXNwEtD91robiwnZPWjRcztSi1bZpWpmusPthVk32iD8nkGHtmaiWVI-VE4cCZrvUk9YQnBsdLgsRtMTmjH4GhtvWBkZ2nF-eZTVhei7_hYwvNb4oxsfqmypV0q70THeqGuThliKDEMpI7qhg');
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    print(context.router.currentPath);

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: deviceWidth,
          child: Image.network(
            place.photoUrl,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    TopBar(place: place),
                    MainContentBox(place: place, dogs: dogs),
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
  const TopBar({super.key, required this.place});

  final Place place;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  late bool likeClicked;

  @override
  void initState() {
    super.initState();

    // TODO pobranie czy użytkownik już ma polajkowane miejsce
    likeClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    const iconContainerSize = 40.0;
    const iconSize = 30.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  color: AppColor.darkText.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => context.router.pop(),
                    icon: const Icon(
                      FluentSystemIcons.ic_fluent_arrow_left_regular,
                      size: iconSize,
                      color: Colors.white,
                    )
                ),
              ),
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  color: AppColor.darkText.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    key: ValueKey<bool>(likeClicked),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => addLike(),
                      icon: Icon(
                        likeClicked ? FluentSystemIcons.ic_fluent_heart_filled : FluentSystemIcons.ic_fluent_heart_regular,
                        size: iconSize,
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addLike() {
    setState(() {
      likeClicked = !likeClicked;
    });
  }
}

class MainContentBox extends StatelessWidget {
  const MainContentBox({super.key, required this.place, required this.dogs});

  final Place place;
  final List<Dog> dogs;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    const double mainContainerMarginTop = 250.0;
    const double bottomBarHeight = 80.0;

    return Container(
      margin: const EdgeInsets.only(top: mainContainerMarginTop),
      width: deviceWidth,
      constraints: BoxConstraints(
        minHeight: deviceHeight - bottomBarHeight - mainContainerMarginTop,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(place.name, style: AppTextStyle.heading2.copyWith(fontSize: 25.0),)),
                  TextButton(
                      onPressed: () => {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FluentSystemIcons.ic_fluent_star_filled,
                            size: 18,
                            color: AppColor.primaryOrange,
                          ),
                          const Gap(2.0),
                          Text('${place.averageScore}', style: AppTextStyle.regularLight,),
                        ],
                      )
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: AppColor.primaryOrange,
                  ),
                  Text('${place.street}, ${place.zipCode} ${place.city}', style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0),),
                ],
              ),
              const Gap(20.0),
              Text('${place.description}', style: AppTextStyle.regularLight.copyWith(fontSize: 14.0)),
              const Gap(10.0),
              Row(
                children: [
                  Text('Dogs here', style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
                  const Gap(5.0),
                  Text('(${dogs.length})', style: AppTextStyle.mediumLight,)
                ],
              ),
              const Gap(10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DogInfoBox(dog: dogs[index]),
                      const Gap(15.0),
                    ],
                  );
                },
              ),
              ElevatedButton(onPressed: () {
              }, child: Container(
                width: 30,
                height: 30,
                color: Colors.red
              ))
            ],
          ),
        ),
      ),
    );
  }
}
