import 'package:flutter/material.dart';
import 'package:jedi/logic/cubit/course/course_cubit.dart';

import '../screens/home_screen/widgets/arrived_students_progress_indicator.dart';
import 'course_details.dart';
import 'theme_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/core/extensions/color_utils.dart';

class StatisticsContainer extends StatelessWidget {
  final bool showIndicator;
  final double screenPortion;

  const StatisticsContainer({
    Key? key,
    required this.showIndicator,
    required this.screenPortion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: _containterDecoration(context),
      height: size.height * screenPortion,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showIndicator
              ? ArrivedStudentsProgressIndicator()
              : SizedBox(width: size.width * 0.1),
          SizedBox(
            width: size.width * 0.05,
          ),
          CourseDetails(
            courseName:
                'קורס ${(context.read<CourseCubit>().state as CourseSelected).selectedCourse.name}',
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          ThemeButton(),
        ],
      ),
    );
  }

  BoxDecoration _containterDecoration(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BoxDecoration(
      gradient: LinearGradient(
        stops: [0, 0.7, 1],
        colors: [
          theme.primaryColor.darken(15),
          theme.primaryColor,
          theme.primaryColor.brighten(45)
        ],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 10,
          color: Colors.black26,
        ),
      ],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    );
  }
}
