import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/providers/user_dogs_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/widgets/routing_circle_add_button.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:front_flutter/styles.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DogsScreen extends StatefulWidget {
  const DogsScreen({Key? key}) : super(key: key);

  @override
  State<DogsScreen> createState() => _DogsScreenState();
}

class _DogsScreenState extends State<DogsScreen> {
  final dogService = DogService();
  late final UserDogsProvider userDogsProvider;

  @override
  void initState() {
    super.initState();
    userDogsProvider = context.read<UserDogsProvider>();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDogsProvider>(
      builder: (context, userDogsProvider, _) {
          List<Dog>? dogs = userDogsProvider.dogs;
          if (dogs != null) {
            return dogs.isNotEmpty ?
            DogsListPage(userDogs: dogs, refresh: () => refresh()) :
            const EmptyDogsListPage();
          } else {
            return const SizedLoadingIndicator(color: AppColor.primaryOrange);
          }
      },
    );
  }
}

class EmptyDogsListPage extends StatelessWidget {
  const EmptyDogsListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dogImageSize = 100.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/first_dog.png',
          width: dogImageSize,
        ),
        const Gap(10.0),
        Text('Add your first dog', style: AppTextStyle.semiBoldOrange.copyWith(fontSize: 18)),
        const Gap(10.0),
        RoutingCircleAddButton(route: DogDetailsRoute(onComplete: () {})),
      ],
    );
  }
}

class DogsListPage extends StatefulWidget {
  final List<Dog> userDogs;
  final Function() refresh;


  const DogsListPage({
    Key? key,
    required this.userDogs,
    required this.refresh
  }) : super(key: key);

  @override
  State<DogsListPage> createState() => _DogsListPageState();
}

class _DogsListPageState extends State<DogsListPage> {

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: 60.0,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: AppColor.primaryOrange,
              ),
              child: Center(
                  child: Text('Your dogs', style: AppTextStyle.whiteHeading)
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.userDogs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    DogInfoBox(dog: widget.userDogs[index],),
                    const Gap(15.0),
                  ],
                );
              },
            ),
            Center(
                child: RoutingCircleAddButton(route: DogDetailsRoute(onComplete: () => widget.refresh()))
            ),
            const Gap(20.0),
          ],
        )
    );
  }
}
