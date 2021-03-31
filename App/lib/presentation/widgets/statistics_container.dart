import 'package:flutter/material.dart';

import '../screens/home_screen/widgets/arrived_students_progress_indicator.dart';
import 'course_details.dart';
import 'theme_button.dart';

class StatisticsContainer extends StatelessWidget {
  const StatisticsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: _containterDecoration(),
      height: size.height * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ArrivedStudentsProgressIndicator(),
          SizedBox(
            width: size.width * 0.05,
          ),
          CourseDetails(
            courseName: 'קורס רצ"ה',
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          ThemeButton(),
        ],
      ),
    );
  }

  BoxDecoration _containterDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        stops: [0, 0.7, 1],
        colors: [Color(0xFF69B981), Color(0xFF89C99E), Color(0xFFB4DFC5)],
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
