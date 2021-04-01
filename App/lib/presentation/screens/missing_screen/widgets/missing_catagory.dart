import 'package:flutter/material.dart';
import 'package:jedi/presentation/widgets/theme_button.dart';

class MissingCatagory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<DropdownMenuItem> _dropDownItems = [
      DropdownMenuItem(child: Text("התמקצעות")),
      DropdownMenuItem(child: Text("מתפללים")),
      DropdownMenuItem(child: Text("אישור סגל")),
      DropdownMenuItem(child: Text("מאחר")),
    ];

    return Container(
      decoration: _containterDecoration(),
      height: size.height * 0.18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _dropDownItems[0],
                items: _dropDownItems,
              ),
              Text("לחיצה על שם תעביר אותו לקטגוריה"),
            ],
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
