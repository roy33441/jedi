import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/data/data_providers/report_type_data_provider.dart';
import 'package:jedi/data/data_providers/student_missing_provider.dart';
import 'package:jedi/data/data_providers/student_report_provider.dart';
import 'package:jedi/data/repositories/report_type_repository.dart';
import 'package:jedi/data/repositories/student_missing_repository.dart';
import 'package:jedi/data/repositories/student_report_repository.dart';
import 'package:jedi/logic/cubit/manual_report/manual_report_cubit.dart';
import 'package:jedi/logic/cubit/report_type/report_type_cubit.dart';
import 'package:jedi/logic/cubit/student_missing/student_missing_cubit.dart';
import 'package:jedi/logic/cubit/student_report/student_report_cubit.dart';
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
      baseUrl: 'http://10.0.2.2:8080',
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
          BlocProvider<ReportTypeCubit>(
            create: (_) => ReportTypeCubit(
              reportTypeRepository: ReportTypeRepository(
                remoteDataProvider: ReportTypeRemoteDataProvider(client: dio),
              ),
            ),
          ),
          BlocProvider<StudentReportCubit>(
            create: (_) => StudentReportCubit(
              repository: StudentReportRepository(
                remoteDataProvider:
                    StudentReportRemoteDataProvider(client: dio),
              ),
            ),
          ),
          BlocProvider<StudentMissingCubit>(
            create: (_) => StudentMissingCubit(
              repository: StudentMissingRepository(
                remoteDataProvider:
                    StudentMissingRemoteDataProvider(client: dio),
              ),
            ),
          ),
          BlocProvider<ManualReportCubit>(
            create: (context) =>
                ManualReportCubit(context.read<StudentsBloc>()),
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
