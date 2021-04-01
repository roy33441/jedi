import 'package:flutter/material.dart';
import 'package:jedi/core/constants/strings.dart';
import 'package:jedi/presentation/screens/formation_screen/formation_screen.dart';
import 'package:jedi/presentation/screens/missing_screen/missing_screen.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class RouteInfo {
  final String path;
  final IconData iconData;
  final String title;

  RouteInfo({
    required this.path,
    required this.iconData,
    required this.title,
  });
}

class AppRouter {
  static const String home = '/';
  static const String formation = '/formation';
  static const String missings = '/missings';
  static final List<RouteInfo> routesInfo = [
    RouteInfo(
        path: missings,
        iconData: Icons.not_interested,
        title: Strings.missingsRouteTitle),
    RouteInfo(
        path: home,
        iconData: Icons.new_releases,
        title: Strings.homeRouteTitle),
    RouteInfo(
        path: formation,
        iconData: Icons.people,
        title: Strings.formationRouteTitle),
  ];

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case formation:
        return MaterialPageRoute(
          builder: (_) => FormationScreen(),
        );
      case missings:
        return MaterialPageRoute(
          builder: (_) => MissingScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
