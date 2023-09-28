import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../styles.dart';

@RoutePage(name: 'BottomBarRoute')
class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: Colors.white,
      routes: const [
        HomeRouter(),
        DogsRouter(),
        MapRouter(),
        PlacesRouter(),
        UserProfileRouter(),
      ],
      appBarBuilder: (_, tabsRouter) {
        return AppBar(
          toolbarHeight: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryOrange,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      },
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          backgroundColor: AppColor.orangeAccent,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedItemColor: AppColor.primaryOrange,
          unselectedItemColor: AppColor.primaryOrange,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_fluent_animal_dog_24_regular.svg',
                colorFilter: const ColorFilter.mode(AppColor.primaryOrange, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_fluent_animal_dog_24_filled.svg',
                colorFilter: const ColorFilter.mode(AppColor.primaryOrange, BlendMode.srcIn),
              ),
              label: 'Dogs',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_fluent_compass_northwest_24_regular.svg',
                colorFilter: const ColorFilter.mode(AppColor.primaryOrange, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_fluent_compass_northwest_24_filled.svg',
                colorFilter: const ColorFilter.mode(AppColor.primaryOrange, BlendMode.srcIn),
              ),
              label: 'Map',
            ),
            const BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_city_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_city_filled),
              label: "Places",
            ),
            const BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
