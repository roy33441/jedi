import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/core/themes/app_theme.dart';
import 'package:jedi/logic/cubit/course/course_cubit.dart';
import 'package:jedi/logic/entities/course_entity.dart';
import 'package:jedi/presentation/widgets/navigator_view.dart';

class CourseSelectBody extends StatefulWidget {
  const CourseSelectBody({Key? key}) : super(key: key);

  @override
  _CourseSelectBodyState createState() => _CourseSelectBodyState();
}

class _CourseSelectBodyState extends State<CourseSelectBody> {
  int? selectedCourseId;
  late CourseState courseState;
  late List<CourseEntity> courses;

  @override
  void initState() {
    courseState = context.read<CourseCubit>().state;
    courses = courseState is CourseFetchSuccess
        ? (courseState as CourseFetchSuccess).courses
        : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey[900],
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: size.width * 0.8,
              child: DropdownButtonFormField<int>(
                hint: Text('יש לבחור קורס'),
                items: _buildCoursesDropdownItems(context),
                onChanged: (value) {
                  setState(() {
                    selectedCourseId = value;
                  });
                },
                value: selectedCourseId,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (selectedCourseId != null)
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: MaterialButton(
                child: Text(
                  'אישור',
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                color: Theme.of(context).success,
                onPressed: () {
                  context.read<CourseCubit>().selectCourse(selectedCourseId!);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => NavigatorView(courseId: selectedCourseId!),
                  ));
                },
              ),
            )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildCoursesDropdownItems(BuildContext context) {
    final coursesState = context.read<CourseCubit>().state;

    if (coursesState is CourseFetchSuccess) {
      return coursesState.courses
          .map<DropdownMenuItem<int>>(
            (course) => DropdownMenuItem<int>(
              value: course.id,
              child: Text(
                course.name,
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
          .toList();
    }

    return [];
  }
}
