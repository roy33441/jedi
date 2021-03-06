import 'package:flutter/material.dart';

import 'missing_students_autocomplete.dart';

class ManualReportDialog extends StatelessWidget {
  const ManualReportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            width: size.width * 0.8,
            child: MissingStudentsAutocomplete(),
          ),
        ),
      ),
    );
  }
}
