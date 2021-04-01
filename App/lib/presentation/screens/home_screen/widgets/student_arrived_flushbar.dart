import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class StudentArrivedFlushBar extends Flushbar {
  StudentArrivedFlushBar({required String studentName})
      : super(
          margin: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          messageText: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'הדיווח על $studentName בוצע בהצלחה',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '   ✔',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(milliseconds: 1300),
          flushbarPosition: FlushbarPosition.TOP,
        );
}
