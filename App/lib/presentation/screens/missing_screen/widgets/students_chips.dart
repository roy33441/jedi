import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jedi/logic/entities/student.dart';
import '../../formation_screen/extensions/rtl_scrollable_list_view.dart';

typedef void PressFunction(StudentEntity student);

class StudentsChips extends HookWidget {
  final List<StudentEntity> missingStudents;
  final PressFunction onPress;
  final Color backgroundColor;
  final Icon? icon;

  const StudentsChips({
    Key? key,
    required this.missingStudents,
    required this.onPress,
    this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useScrollController();
    final size = MediaQuery.of(context).size;
    return ListView(
      controller: _controller,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5.0,
          children: missingStudents
              .map(
                (student) => Container(
                  margin: EdgeInsets.only(top: 5.0, right: 4.0),
                  child: ActionChip(
                    avatar: icon,
                    onPressed: () => onPress(student),
                    backgroundColor: Theme.of(context).highlightColor,
                    labelPadding: EdgeInsets.all(5.0),
                    label: Text(
                      student.fullName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ).addRtlAndScroll(
      context: context,
      controller: _controller,
      mediaQuerySize: size,
      height: 0.35,
    );
  }
}
