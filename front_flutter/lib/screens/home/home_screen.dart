import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/place.dart';
import 'package:front_flutter/widgets/favorite_place_box.dart';
import 'package:front_flutter/widgets/walk_info_box.dart';
import 'package:front_flutter/widgets/walk_partner_box.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/behavior.dart';
import '../../models/dog/dog.dart';
import '../../models/user.dart';
import '../../models/walk.dart';
import '../../providers/user_provider.dart';
import '../../styles.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final Place _place;
  late final Walk? _walk;
  late final Dog _dog;
  late final UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    _place = Place(1, 'Kleparski wybieg', 'Park kleparski', '30-002', 'Kraków', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est.', 2, 5.0, 'https://lh6.googleusercontent.com/UdJXDyQXNwEtD91robiwnZPWjRcztSi1bZpWpmusPthVk32iD8nkGHtmaiWVI-VE4cCZrvUk9YQnBsdLgsRtMTmjH4GhtvWBkZ2nF-eZTVhei7_hYwvNb4oxsfqmypV0q70THeqGuThliKDEMpI7qhg');
    _walk = null;
    userProvider = context.read<UserProvider>();
    userProvider.fetchUser();
    final List<Behavior> exampleBehaviors = [Behavior(1, 'Friendly'), Behavior(6, 'Calm'), Behavior(12, 'Curious'), Behavior(10, 'Independent')];
    _dog = Dog('12', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG', 'Small', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.', 5, exampleBehaviors, 10);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 140.0,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: AppColor.primaryOrange,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ready to walk,', style: AppTextStyle.semiBoldWhite.copyWith(fontSize: 18.0)),
                          Consumer<UserProvider>(builder: (context, userProvider, _) {
                            return Text('${userProvider.user?.firstName}?', style: AppTextStyle.boldWhite.copyWith(fontSize: 25.0),);
                          }),
                        ],
                      ),
                      PhysicalModel(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        elevation: 10.0,
                        child: Consumer<UserProvider>(builder: (context, userProvider, _) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(userProvider.user!.photoUrl!),
                            radius: 40.0,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 30.0,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        color: AppColor.primaryOrange,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth,
                    height: 30.0,
                  )
                ],
              ),
              Container(
                width: deviceWidth,
                height: 40.0,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 9),
                          blurRadius: 20,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.15)
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        FluentSystemIcons.ic_fluent_search_regular,
                        color: AppColor.primaryOrange,
                        size: 20.0,
                      ),
                      const Gap(5.0),
                      Expanded(
                          child: Text('Search', style: AppTextStyle.regularOrange,)
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const Gap(10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _walk != null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You\'re here', style: AppTextStyle.boldDark.copyWith(fontSize: 25.0)),
                    const Gap(10.0),
                    WalkInfoBox(walk: _walk!),
                    const Gap(20.0),
                  ],
                ) : null,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('You\'re walk partners', style: AppTextStyle.boldDark.copyWith(fontSize: 25.0)),
              ),
              const Gap(10.0),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, right: 20.0),
                  child: Row(
                    children: [
                      WalkPartnerBox(
                        dog: _dog,
                        onSelected: (bool value) {
                          print(value);
                        },
                      ),
                      const Gap(20.0),
                      WalkPartnerBox(
                        dog: _dog,
                        onSelected: (bool value) {
                          print(value);
                        },
                      ),
                      const Gap(20.0),
                      WalkPartnerBox(
                        dog: _dog,
                        onSelected: (bool value) {
                          print(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Favorite places', style: AppTextStyle.boldDark.copyWith(fontSize: 25.0)),
              ),
              const Gap(10.0),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, right: 20.0),
                  child: Row(
                    children: [
                      FavoritePlaceBox(place: _place)
                    ],
                  ),
                ),
              ),
              const Gap(20.0),
            ],
          )
        ],
      )
    );
  }
}
