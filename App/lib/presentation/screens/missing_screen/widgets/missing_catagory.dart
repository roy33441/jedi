import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/report_missing_students/report_missing_students_cubit.dart';
import '../../../../logic/entities/missing_reason.dart';
import '../../../widgets/theme_button.dart';

class MissingCatagory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final reportMissingStudentCubit =
        context.read<ReportMissingStudentsCubit>();
    final reasons = context
        .select<ReportMissingStudentsCubit, List<MissingReasonEntity>>((cubit) {
      final currentState = cubit.state;
      return currentState.missingReasons!.length > 0
          ? currentState.missingReasons!
          : [];
    });

    return Container(
      decoration: _containterDecoration(),
      height: size.height * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (reasons.length > 0)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                    ),
                    child: DropdownButtonFormField(
                      icon: Icon(
                        Icons.expand_more,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 25,
                          // vertical: 10,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      selectedItemBuilder: (context) => _buildMenuItems(
                        reasons,
                        Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        false,
                      ),
                      value: reasons[0].text,
                      onChanged: (String? value) =>
                          reportMissingStudentCubit.changeReason(value!),
                      items: _buildMenuItems(
                        reasons,
                        TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        true,
                      ),
                    ),
                  ),
                ),
              ThemeButton(),
            ],
          ),
          Text(
            "לחיצה על שם תעביר אותו לקטגוריה",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMenuItems(
    List<MissingReasonEntity> _dropDownItems,
    TextStyle style,
    bool withBorder,
  ) {
    return _dropDownItems.map(
      (item) {
        return DropdownMenuItem(
          value: item.text,
          child: Container(
            decoration: withBorder
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : null,
            alignment: Alignment.center,
            padding: withBorder ? EdgeInsets.only(top: 0, bottom: 10) : null,
            child: new Text(
              item.text,
              style: style,
            ),
          ),
        );
      },
    ).toList();
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
