import 'package:flutter/material.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../widgets/statistics_container.dart';
import 'manual_report_dialog.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          StatisticsContainer(
            showIndicator: true,
            screenPortion: 0.25,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: size.height * 0.625,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.ready_to_scan,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w900, fontSize: 23),
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
                          .bodyText1!
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ManualReportDialog(),
                        );
                      },
                      color: Theme.of(context).success,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        Strings.certificateNotWorking,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
