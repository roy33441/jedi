import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/presentation/widgets/navigator_view.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'data/data_providers/students_data_provider.dart';
import 'data/repositories/students_repository.dart';
import 'logic/bloc/students_bloc/students_bloc.dart';
import 'logic/debug/app_bloc_observer.dart';

// Credits:
// Juhseer and Royky
void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://05ba4dd0-77e0-4ece-b9cd-ff89bcff59e1.mock.pstmn.io',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<StudentsBloc>(
            create: (_) => StudentsBloc(
              repository: StudentsRepository(
                remoteDataProvider: StudentsRemoteDataProvider(client: dio),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: Strings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: NavigatorView(),
        ));
  }
}
