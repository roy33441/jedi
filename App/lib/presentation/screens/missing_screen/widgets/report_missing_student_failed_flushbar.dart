import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class ReportMissingStudentFailedFlushbar extends Flushbar {
  ReportMissingStudentFailedFlushbar(
      {required BuildContext context, required String studentName})
      : super(
          margin: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          messageText: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'הדיווח על $studentName נכשל',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '   X',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
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
