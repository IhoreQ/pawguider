import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';

import '../../models/dog/behavior.dart';
import '../../models/place.dart';
import '../../styles.dart';
import '../../widgets/common_loading_indicator.dart';

@RoutePage()
class PlaceProfileScreen extends StatefulWidget {
  const PlaceProfileScreen({super.key, @PathParam() required this.placeId});

  final int placeId;

  @override
  State<PlaceProfileScreen> createState() => _PlaceProfileScreenState();
}

class _PlaceProfileScreenState extends State<PlaceProfileScreen> {
  late List<Dog> dogs;
  final PlaceService placeService = PlaceService();

  @override
  void initState() {
    super.initState();

    final List<Behavior> exampleBehaviors = [
      Behavior(1, 'Friendly'),
      Behavior(6, 'Calm'),
      Behavior(12, 'Curious'),
      Behavior(10, 'Independent')
    ];
    final Dog exampleDog = Dog(
        12,
        'Ciapek',
        'Jack Russel Terrier',
        'Male',
        12,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG',
        'Small',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.',
        5,
        exampleBehaviors,
        10,
        false);
    final Dog exampleDog2 = Dog(
        13,
        'Binia',
        'Mongrel',
        'Female',
        2,
        'https://www.pedigree.pl/cdn-cgi/image/width=520,format=auto,q=90/sites/g/files/fnmzdf4096/files/2023-01/jack-russell-terrier_1640009953951.png',
        'Small',
        '',
        10,
        exampleBehaviors,
        11,
        false);

    dogs = [exampleDog, exampleDog2];
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<Place>(
        future: placeService.getPlaceById(widget.placeId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Place place = snapshot.data!;
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
                          TopBar(place: place),
                          MainContentBox(place: place, dogs: dogs, refreshFunction: refresh,),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]);
          }

          return const SizedLoadingIndicator(color: AppColor.primaryOrange);
        },
      ),
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
  late bool _liked;

  @override
  void initState() {
    super.initState();

    // TODO pobranie czy użytkownik już ma polajkowane miejsce
    _liked = widget.place.likedByUser!;
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
                      onPressed: () => addLike(),
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

  void addLike() {
    setState(() {
      _liked = !_liked;
    });
  }
}

class MainContentBox extends StatefulWidget {
  const MainContentBox({super.key, required this.place, required this.dogs, required this.refreshFunction});

  final Place place;
  final List<Dog> dogs;
  final Function() refreshFunction;

  @override
  State<MainContentBox> createState() => _MainContentBoxState();
}

class _MainContentBoxState extends State<MainContentBox> {
  late double _placeRating;
  final PlaceService placeService = PlaceService();


  @override
  void initState() {
    super.initState();
    _placeRating = widget.place.scoreByUser!;
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
                    '${widget.place.street}, ${widget.place.zipCode} ${widget.place.city}',
                    style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
              const Gap(20.0),
              Text('${widget.place.description}',
                  style: AppTextStyle.regularLight.copyWith(fontSize: 14.0)),
              const Gap(10.0),
              Row(
                children: [
                  Text('Dogs here',
                      style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
                  const Gap(5.0),
                  Text(
                    '(${widget.dogs.length})',
                    style: AppTextStyle.mediumLight,
                  )
                ],
              ),
              const Gap(10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.dogs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DogInfoBox(
                        dog: widget.dogs[index],
                        onComplete: () {},
                      ),
                      const Gap(15.0),
                    ],
                  );
                },
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
                      // TODO wysyłka na API i odbiór
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
                            bool success;

                            success = widget.place.ratedByUser! ?
                                await placeService.updateRating(widget.place.id, _placeRating) :
                                await placeService.addRating(widget.place.id, _placeRating);

                            if (success) {
                              print('update');
                              widget.refreshFunction();
                              if (context.mounted) {
                                context.router.pop();
                              }
                            } else {
                              print('error');
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
