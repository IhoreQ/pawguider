import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/favourite_places_provider.dart';
import 'package:front_flutter/providers/user_dogs_provider.dart';
import 'package:front_flutter/providers/user_location_provider.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/widgets/favorite_place_box.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:front_flutter/widgets/walk_info_box.dart';
import 'package:front_flutter/widgets/walk_partner_box.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/walk.dart';
import '../../providers/active_walk_provider.dart';
import '../../providers/user_provider.dart';
import '../../styles.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final dogService = DogService();
  late final UserProvider userProvider;
  late final UserDogsProvider userDogsProvider;
  late final FavouritePlacesProvider favouritePlacesProvider;
  late final UserLocationProvider userLocationProvider;
  late final ActiveWalkProvider activeWalkProvider;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
    favouritePlacesProvider = context.read<FavouritePlacesProvider>();
    userDogsProvider = context.read<UserDogsProvider>();
    activeWalkProvider = context.read<ActiveWalkProvider>();
    userLocationProvider = context.read<UserLocationProvider>();

    userProvider.fetchCurrentUser(context);
    userLocationProvider.fetchUserPosition();
    userLocationProvider.startListeningLocationUpdates(activeWalkProvider);

    favouritePlacesProvider.fetchFavouritePlaces();
    userDogsProvider.fetchUserDogs();
    activeWalkProvider.fetchActiveWalk();
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
                Consumer<ActiveWalkProvider>(
                    builder: (context, activeWalkProvider, _) {
                      Walk? walk = activeWalkProvider.walk;
                      return walk != null ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('You\'re here', style: AppTextStyle.boldDark.copyWith(fontSize: 25.0)),
                            const Gap(10.0),
                            WalkInfoBox(walk: walk),
                            const Gap(20.0),
                          ],
                        ),
                      ) : const SizedBox();
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('You\'re walk partners', style: AppTextStyle.boldDark.copyWith(fontSize: 22.0)),
                ),
                const Gap(10.0),
                Consumer<UserDogsProvider>(
                  builder: (context, userDogsProvider, _) {
                      return userDogsProvider.dogs != null ?
                          userDogsProvider.dogs!.isNotEmpty ?
                            SingleChildScrollView(
                              padding: const EdgeInsets.only(left: 20.0),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  children: userDogsProvider.dogs!.map((dog) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: WalkPartnerBox(dog: dog),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ) : Column(
                              children: [
                                const Gap(20.0),
                                Center(child: Text("Add your first dog to start walking!", style: AppTextStyle.mediumDark.copyWith(fontSize: 14.0),)),
                                const Gap(20.0),
                              ],
                            )
                      : const SizedLoadingIndicator(color: AppColor.primaryOrange);
                    }
                ),
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Favourite places', style: AppTextStyle.boldDark.copyWith(fontSize: 22.0)),
                ),
                Consumer<FavouritePlacesProvider>(builder: (context, favouritePlacesProvider, _) {
                  return favouritePlacesProvider.favouritePlaces != null && favouritePlacesProvider.favouritePlaces!.isNotEmpty ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  ) : Column(
                        children: [
                          const Gap(20.0),
                          Center(child: Text("No places have been liked yet.", style: AppTextStyle.mediumDark.copyWith(fontSize: 14.0),)),
                          const Gap(20.0),
                        ],
                  );
                }),
              ],
            )
          ],
        );
      })
    );
  }
}
