import 'package:flutter/material.dart';

extension RTLScrollableListView on ListView {
  addRtlAndScroll(
      {required ScrollController controller, required Size mediaQuerySize}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: mediaQuerySize.height * 0.35,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Scrollbar(
            controller: controller,
            radius: Radius.circular(5),
            thickness: 8,
            isAlwaysShown: true,
            child: this,
          ),
        ),
      ),
    );
  }
}
