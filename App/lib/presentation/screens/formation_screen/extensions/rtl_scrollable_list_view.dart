import 'package:flutter/material.dart';

extension RTLScrollableListView on ListView {
  addRtlAndScroll({
    required BuildContext context,
    required ScrollController controller,
    required Size mediaQuerySize,
    required double height,
  }) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: mediaQuerySize.height * height,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.03),
            child: Scrollbar(
              controller: controller,
              radius: Radius.circular(5),
              thickness: 8,
              isAlwaysShown: true,
              child: this,
            ),
          ),
        ),
      ),
    );
  }
}
