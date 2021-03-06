import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/students_bloc/students_bloc.dart';
import '../router/app_router.dart';
import 'bottom_nav_bar.dart';

class NavigatorView extends StatefulWidget {
  final int courseId;
  const NavigatorView({Key? key, required this.courseId}) : super(key: key);

  @override
  _NavigatorViewState createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  @override
  void initState() {
    context.read<StudentsBloc>().add(StudentsFetch(courseId: widget.courseId));
    super.initState();
  }

  final _homePageIndex = 1;

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        initialSelelction: _homePageIndex,
        routes: AppRouter.routesInfo,
        navigator: navigator,
      ),
      body: Navigator(
        key: navigator,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
