import 'package:flutter/material.dart';

class CourseSelectBody extends StatelessWidget {
  const CourseSelectBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: SizedBox(
          width: size.width * 0.8,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            items: [DropdownMenuItem(child: Text('בדיקה'))],
          ),
        ),
      ),
    );
  }
}
