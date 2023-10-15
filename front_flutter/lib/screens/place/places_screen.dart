import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/widgets/place_info_box.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../providers/user_provider.dart';
import '../../styles.dart';
import '../../widgets/common_loading_indicator.dart';

@RoutePage()
class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {

  final PlaceService placeService = PlaceService();
  late final UserProvider userProvider;


  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 80.0,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: AppColor.primaryOrange,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(20.0),
                Text('Places', style: AppTextStyle.whiteHeading),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                        return Text(userProvider.user?.cityName ?? '', style: AppTextStyle.mediumWhite,);
                      },
                    ),
                  ],
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
          const Gap(20.0),
          FutureBuilder<List<Place>>(
            future: placeService.getPlacesByCityId(userProvider.user!.cityId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Place> places = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        PlaceInfoBox(place: places[index]),
                        const Gap(15.0),
                      ],
                    );
                  },
                );
              }

              return const SizedLoadingIndicator(color: AppColor.primaryOrange);
            }
          ),
        ],
      ),
    );
  }
}
