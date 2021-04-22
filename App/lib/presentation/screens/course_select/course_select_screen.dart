import 'package:flutter/material.dart';
import 'package:jedi/logic/cubit/cubit/course_cubit.dart';
import 'package:jedi/presentation/screens/course_select/widgets/course_select_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSelectScreen extends StatefulWidget {
  const CourseSelectScreen({Key? key}) : super(key: key);

  @override
  _CourseSelectScreenState createState() => _CourseSelectScreenState();
}

class _CourseSelectScreenState extends State<CourseSelectScreen> {
  @override
  void initState() {
    context.read<CourseCubit>().fetchOpenCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CourseSelectBody(),
    );
  }
}
