import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/behavior.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/widgets/routing_circle_add_button.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:gap/gap.dart';
import 'package:front_flutter/styles.dart';

@RoutePage()
class DogsScreen extends StatelessWidget {
  DogsScreen({Key? key}) : super(key: key);

  // TODO basicInfo constructor dla psów

  final List<Behavior> exampleBehaviors = [Behavior(1, 'Friendly'), Behavior(6, 'Calm'), Behavior(12, 'Curious'), Behavior(10, 'Independent')];

  late final Dog exampleDog = Dog('12', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG', 'Small', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque non ante at diam elementum volutpat a ac neque. In eu dui accumsan, viverra urna eget, sagittis diam. Pellentesque eget pharetra odio, vitae volutpat est. Maecenas quis sapien aliquam, porta eros a, pretium nunc. Fusce velit orci, volutpat nec urna in, euismod varius diam. Suspendisse quis ante tellus. Quisque aliquam malesuada justo eget accumsan.', 5, exampleBehaviors, 10);
  late final Dog exampleDog2 = Dog('13', 'Binia', 'Mongrel', false, 2, 'https://www.pedigree.pl/cdn-cgi/image/width=520,format=auto,q=90/sites/g/files/fnmzdf4096/files/2023-01/jack-russell-terrier_1640009953951.png', 'Small', '', 10, exampleBehaviors, 11);

  @override
  Widget build(BuildContext context) {
    List<Dog> userDogs = [exampleDog, exampleDog2];

    return userDogs.isNotEmpty ?
        DogsListPage(userDogs: userDogs) :
        const EmptyDogsListPage();
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
        RoutingCircleAddButton(route: DogDetailsRoute()),
      ],
    );
  }
}

class DogsListPage extends StatelessWidget {
  final List<Dog> userDogs;

  const DogsListPage({
    Key? key,
    required this.userDogs
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
            // TODO Pobranie listy psów z API oraz wyświetlenie
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userDogs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    DogInfoBox(dog: userDogs[index]),
                    const Gap(15.0),
                  ],
                );
              },
            ),
            Center(
                child: RoutingCircleAddButton(route: DogDetailsRoute())
            ),
            const Gap(20.0),
          ],
        )
    );
  }


}
