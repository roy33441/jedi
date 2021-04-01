import 'package:flutter/material.dart';
import 'package:jedi/core/themes/app_theme.dart';
import 'package:jedi/logic/entities/student.dart';

class FormationReportDialog extends StatelessWidget {
  final StudentEntity student;
  const FormationReportDialog({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(
          student.fullName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: _buildFormationReportTypes(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'שמור דיווח',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                onPressed: () {},
                color: AppTheme.success_color,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormationReportTypes() {
    final reportTypes = [
      'גלח"ץ',
      'כומתה',
      'שיער',
      'תגיות',
      'גילוח',
      'אחר',
    ];

    return reportTypes
        .map((type) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  activeColor: AppTheme.success_color,
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  type,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ))
        .toList();
  }
}
