import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:jedi/presentation/router/app_router.dart';

class BottomNavBar extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;
  final List<RouteInfo> routes;
  final int initialSelelction;
  const BottomNavBar({
    Key? key,
    required this.navigator,
    required this.routes,
    required this.initialSelelction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
      style: BottomNavbarStyle(),
      child: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        color: Colors.white,
        activeColor: Theme.of(context).primaryColor,
        elevation: 10,
        items: [
          for (RouteInfo route in routes)
            TabItem(icon: route.iconData, title: route.title)
        ],
        initialActiveIndex: initialSelelction,
        onTap: (index) => _changeRoute(index),
      ),
    );
  }

  void _changeRoute(index) {
    final newRoute = routes[index];
    navigator.currentState!.pushNamed(newRoute.path);
  }
}

class BottomNavbarStyle extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 12, color: color);
  }
}
