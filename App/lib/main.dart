import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jedi/data/data_providers/courses_data_provider.dart';
import 'package:jedi/data/repositories/courses_repository.dart';
import 'package:jedi/logic/cubit/cubit/course_cubit.dart';
import 'package:jedi/presentation/screens/course_select/course_select_screen.dart';
import 'package:jedi/presentation/screens/home_screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'data/data_providers/missing_reason_data_provider.dart';
import 'data/data_providers/report_type_data_provider.dart';
import 'data/data_providers/student_missing_provider.dart';
import 'data/data_providers/student_report_provider.dart';
import 'data/data_providers/students_data_provider.dart';
import 'data/repositories/missing_catagory_repository.dart';
import 'data/repositories/report_type_repository.dart';
import 'data/repositories/student_missing_repository.dart';
import 'data/repositories/student_report_repository.dart';
import 'data/repositories/students_repository.dart';
import 'logic/bloc/students_bloc/students_bloc.dart';
import 'logic/cubit/manual_report/manual_report_cubit.dart';
import 'logic/cubit/report_missing_students/report_missing_students_cubit.dart';
import 'logic/cubit/report_type/report_type_cubit.dart';
import 'logic/cubit/student_missing/student_missing_cubit.dart';
import 'logic/cubit/student_report/student_report_cubit.dart';
import 'logic/debug/app_bloc_observer.dart';

// Credits:
// Juhseer and Royky
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(App());
  // TODO clean emits of cubits
}

class App extends StatelessWidget {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      receiveDataWhenStatusError: true,
      connectTimeout: 5 * 1000,
      receiveTimeout: 60 * 1000,
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
          BlocProvider<ReportMissingStudentsCubit>(
            create: (context) => ReportMissingStudentsCubit(
              studentsBloc: context.read<StudentsBloc>(),
              studentMissingCubit: context.read<StudentMissingCubit>(),
              studentMissingRepository: StudentMissingRepository(
                remoteDataProvider:
                    StudentMissingRemoteDataProvider(client: dio),
              ),
              missingReasonRepository: MissingReasonRepository(
                remoteDataProvider: MissingReasonDataProvider(client: dio),
              ),
            ),
          ),
          BlocProvider<ManualReportCubit>(
            create: (context) =>
                ManualReportCubit(context.read<StudentsBloc>()),
          ),
          BlocProvider(
            create: (_) => CourseCubit(
              repository: CoursesRepository(
                remoteDataProvider: CoursesDataProvider(client: dio),
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
          home: Builder(
            builder: (context) {
              if (context.read<CourseCubit>().state is CourseSelected) {
                return HomeScreen();
              } else {
                return CourseSelectScreen();
              }
            },
          ),
        ));
  }
}
