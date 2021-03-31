import 'package:flutter/material.dart';
import 'package:jedi/core/constants/strings.dart';
import 'package:jedi/presentation/widgets/statistics_container.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          StatisticsContainer(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.ready_to_scan,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      !.copyWith(fontWeight: FontWeight.w900, fontSize: 23),
                ),
                Container(
                    height: size.height * 0.23,
                    child: Image(
                        image: AssetImage('assets/images/scan_area.png'))),
                Text(
                  Strings.how_to_scan,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      !.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
