import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/providers/favourite_places_provider.dart';
import 'package:front_flutter/providers/places_provider.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:front_flutter/widgets/sized_error_text.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../exceptions/result.dart';
import '../../models/dog/behavior.dart';
import '../../models/place.dart';
import '../../styles.dart';
import '../../widgets/common_loading_indicator.dart';
import '../error_screen.dart';

@RoutePage()
class PlaceProfileScreen extends StatefulWidget {
  const PlaceProfileScreen({super.key, @PathParam() required this.placeId});

  final int placeId;

  @override
  State<PlaceProfileScreen> createState() => _PlaceProfileScreenState();
}

class _PlaceProfileScreenState extends State<PlaceProfileScreen> {
  final PlaceService placeService = PlaceService();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<Result<Place, ApiError>>(
        future: placeService.getPlaceById(widget.placeId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = switch (snapshot.data!) {
              Success(value: final place) => place,
              Failure(error: final error) => error,
            };

            if (result is Place) {
              final Place place = result;
              return Stack(children: [
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
                            TopBar(place: place, placeService: placeService),
                            MainContentBox(place: place, refreshFunction: refresh,),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]);

            } else {
              final error = result as ApiError;
              return ErrorScreen(
                  errorMessage: error.message,
                  retryFunction: () {
                    refresh();
                  }
              );
            }
          }

          return const SizedLoadingIndicator(color: AppColor.primaryOrange);
        },
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({super.key, required this.place, required this.placeService});

  final Place place;
  final PlaceService placeService;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late bool _liked;
  late FavouritePlacesProvider favouritePlacesProvider;

  @override
  void initState() {
    super.initState();
    _liked = widget.place.likedByUser!;
    favouritePlacesProvider = context.read<FavouritePlacesProvider>();
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
                    )),
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
                      key: ValueKey<bool>(_liked),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => onClickLikeButton(),
                      icon: Icon(
                        _liked
                            ? FluentSystemIcons.ic_fluent_heart_filled
                            : FluentSystemIcons.ic_fluent_heart_regular,
                        size: iconSize,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future onClickLikeButton() async {
    final result = _liked ?
      await widget.placeService.deleteLike(widget.place.id) :
      await widget.placeService.addLike(widget.place.id);

    final value = switch (result) {
      Success(value: final successCode) => successCode,
      Failure(error: final error) => error
    };

    if (value is! ApiError) {
      favouritePlacesProvider.toggleFavouritePlace(widget.place);
      _liked = !_liked;
      setState(() {});
    } else {
      if (context.mounted) {
        showErrorDialog(context: context, message: value.message);
      }
    }
  }
}

class MainContentBox extends StatefulWidget {
  const MainContentBox({super.key, required this.place, required this.refreshFunction});

  final Place place;
  final Function() refreshFunction;

  @override
  State<MainContentBox> createState() => _MainContentBoxState();
}

class _MainContentBoxState extends State<MainContentBox> {
  late double _placeRating;
  final PlaceService placeService = PlaceService();

  late final UserProvider userProvider;
  late final PlacesProvider placesProvider;


  @override
  void initState() {
    super.initState();
    _placeRating = widget.place.scoreByUser!;
    userProvider = context.read<UserProvider>();
    placesProvider = context.read<PlacesProvider>();
  }

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
                  Expanded(
                      child: Text(
                    widget.place.name,
                    style: AppTextStyle.heading2.copyWith(fontSize: 25.0),
                  )),
                  TextButton(
                      onPressed: () => onReviewsClick(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FluentSystemIcons.ic_fluent_star_filled,
                            size: 18,
                            color: AppColor.primaryOrange,
                          ),
                          const Gap(2.0),
                          Text(
                            '${widget.place.averageScore}',
                            style: AppTextStyle.regularLight,
                          ),
                        ],
                      ))
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: AppColor.primaryOrange,
                  ),
                  Text(
                    '${widget.place.street}${widget.place.houseNumber == null ? '' : " ${widget.place.houseNumber}"}, ${widget.place.zipCode} ${widget.place.city}',
                    style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
              const Gap(20.0),
              Text('${widget.place.description}',
                  style: AppTextStyle.regularLight.copyWith(fontSize: 14.0)),
              const Gap(10.0),
              FutureBuilder<Result<List<Dog>, ApiError>>(
                future: placeService.getAllDogsFromPlace(widget.place.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final result = switch (snapshot.data!) {
                      Success(value: final dogs) => dogs,
                      Failure(error: final error) => error
                    };

                    if (result is List<Dog>) {
                      final List<Dog> dogs = result;

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Text('Dogs here',
                                          style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
                                      const Gap(5.0),
                                      Text(
                                        '(${dogs.length})',
                                        style: AppTextStyle.mediumLight,
                                      )
                                    ],
                                  )
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColor.lightGray.withOpacity(0.5),
                                child: IconButton(
                                  style: AppButtonStyle.lightSplashColor,
                                  onPressed: () => widget.refreshFunction(),
                                  icon: const Icon(
                                    Icons.refresh,
                                    size: 20,
                                    color: AppColor.lightText,
                                  ),
                                ),
                              )
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
                                  DogInfoBox(dog: dogs[index],),
                                  const Gap(15.0),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      final error = result as ApiError;
                      return SizedErrorText(message: error.message);
                    }
                  }
                  return const SizedLoadingIndicator(color: AppColor.primaryOrange);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onReviewsClick() async {
    await showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) => BottomSheet(
              enableDrag: false,
              backgroundColor: Colors.white,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(15.0),
                  Text(
                    'Rate this place',
                    style: AppTextStyle.semiBoldDark.copyWith(fontSize: 18.0),
                  ),
                  const Gap(10.0),
                  RatingBar(
                    initialRating: _placeRating,
                    minRating: 1,
                    maxRating: 5,
                    glowColor: AppColor.primaryOrange,
                    onRatingUpdate: (rating) {
                      _placeRating = rating;
                      setState(() {});
                    },
                    allowHalfRating: false,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        FluentSystemIcons.ic_fluent_star_filled,
                        color: AppColor.primaryOrange,
                      ),
                      half: const Icon(FluentSystemIcons.ic_fluent_star_filled),
                      empty: const Icon(
                        FluentSystemIcons.ic_fluent_star_regular,
                        color: AppColor.primaryOrange,
                      ),
                    ),
                  ),
                  const Gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            context.router.pop();
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black.withOpacity(0.3),
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              side: const BorderSide(
                                color: AppColor.primaryOrange,
                                width: 1.5,
                              )),
                          child: Text(
                            'Cancel',
                            style: AppTextStyle.mediumOrange
                                .copyWith(fontSize: 14.0),
                          )),
                      const Gap(20.0),
                      FilledButton(
                          onPressed: () async {
                            final result = widget.place.ratedByUser! ?
                              await placeService.updateRating(widget.place.id, _placeRating) :
                              await placeService.addRating(widget.place.id, _placeRating);

                            final value = switch (result) {
                              Success(value: final successCode) => successCode,
                              Failure(error: final error) => error
                            };

                            if (value is! ApiError) {
                              widget.refreshFunction();
                              int cityId = userProvider.user!.cityId;
                              if (context.mounted) {
                                placesProvider.fetchPlacesByCityId(context, cityId);
                                context.router.pop();
                              }
                            } else {
                              if (context.mounted) {
                                showErrorDialog(context: context, message: value.message);
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColor.primaryOrange,
                            shadowColor: Colors.black.withOpacity(0.3),
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: AppTextStyle.mediumWhite
                                .copyWith(fontSize: 14.0),
                          ))
                    ],
                  ),
                  const Gap(15.0),
                ],
              ),
              onClosing: () {},
            ));
  }
}
