import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/place.dart';
import 'package:front_flutter/models/user.dart';
import 'package:front_flutter/providers/favourite_places_provider.dart';
import 'package:front_flutter/providers/user_dogs_provider.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/widgets/favorite_place_box.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:front_flutter/widgets/walk_info_box.dart';
import 'package:front_flutter/widgets/walk_partner_box.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/dog/behavior.dart';
import '../../models/dog/dog.dart';
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
  final dogService = DogService();
  late final UserProvider userProvider;
  late final UserDogsProvider userDogsProvider;
  late final FavouritePlacesProvider favouritePlacesProvider;

  @override
  void initState() {
    super.initState();

    _place = Place(1, 'Kleparski wybieg', 'Park kleparski', '30-002', 'Kraków', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est.', 5.0, 'https://lh6.googleusercontent.com/UdJXDyQXNwEtD91robiwnZPWjRcztSi1bZpWpmusPthVk32iD8nkGHtmaiWVI-VE4cCZrvUk9YQnBsdLgsRtMTmjH4GhtvWBkZ2nF-eZTVhei7_hYwvNb4oxsfqmypV0q70THeqGuThliKDEMpI7qhg', false, false, 3.0);
    _walk = null;

    userProvider = context.read<UserProvider>();
    favouritePlacesProvider = context.read<FavouritePlacesProvider>();
    userDogsProvider = context.read<UserDogsProvider>();

    userProvider.fetchCurrentUser();
    favouritePlacesProvider.fetchFavouritePlaces();
    userDogsProvider.fetchUserDogs();

    final List<Behavior> exampleBehaviors = [Behavior(1, 'Friendly'), Behavior(6, 'Calm'), Behavior(12, 'Curious'), Behavior(10, 'Independent')];
    _dog = Dog(12, 'Ciapek', 'Jack Russel Terrier', 'Male', 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG', 'Small', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.', 5, exampleBehaviors, 10, false);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return userProvider.user == null ?
        const SizedLoadingIndicator(color: AppColor.primaryOrange)
        : ListView(
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
                            final photoUrl = userProvider.user?.photoUrl;
                            return CircleAvatar(
                              backgroundImage: photoUrl != null
                                  ? NetworkImage(photoUrl)
                                  : null,
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
                  child: Text('You\'re walk partners', style: AppTextStyle.boldDark.copyWith(fontSize: 22.0)),
                ),
                const Gap(10.0),
                Consumer<UserDogsProvider>(
                  builder: (context, userDogsProvider, _) {
                      return userDogsProvider.dogs != null ?
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20.0),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: userDogsProvider.dogs!.map((dog) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: WalkPartnerBox(
                                  dog: dog,
                                  onSelected: (isSelected) => handleDogSelection(isSelected, dog),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ) :
                      const SizedLoadingIndicator(color: AppColor.primaryOrange);
                    }
                ),
                const Gap(10.0),
                Consumer<FavouritePlacesProvider>(builder: (context, favouritePlacesProvider, _) {
                  return favouritePlacesProvider.favouritePlaces != null && favouritePlacesProvider.favouritePlaces!.isNotEmpty ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Favourite places', style: AppTextStyle.boldDark.copyWith(fontSize: 22.0)),
                      ),
                      const Gap(10.0),
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20.0),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: favouritePlacesProvider.favouritePlaces!.map((place) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: FavoritePlaceBox(place: place),
                              );
                            }).toList()
                          ),
                        ),
                      ),
                      const Gap(20.0),
                    ],
                  )
                  : const SizedBox();
                }),
              ],
            )
          ],
        );
      })
    );
  }

  void handleDogSelection(bool isSelected, Dog dog) {
    if (userDogsProvider.isLimitNotExceeded() || !isSelected) {
      dogService.toggleSelected(dog.id);
      if (isSelected) {
        userDogsProvider.incrementDogsCount();
      } else {
        userDogsProvider.decrementDogsCount();
      }
    }
  }
}
