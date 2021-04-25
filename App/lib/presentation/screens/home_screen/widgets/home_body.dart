import 'package:flutter/material.dart';
import 'package:jedi/logic/cubit/course/course_cubit.dart';
import 'package:jedi/presentation/screens/course_select/course_select_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/strings.dart';
import '../../../widgets/statistics_container.dart';
import 'manual_report_dialog.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    // bool isAvailable = await NfcManager.instance.isAvailable();

    // if (isAvailable) {
    //   NfcManager.instance.startSession(
    //     onDiscovered: (NfcTag tag) async {
    //       print(tag.data);
    //     },
    //   );
    // }

    super.initState();
  }

  @override
  void dispose() {
    // NfcManager.instance.stopSession();
    super.dispose();
  }

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
                      color: Theme.of(context).primaryColor,
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
                    ),
                    MaterialButton(
                      color: Theme.of(context).highlightColor,
                      onPressed: () {
                        context.read<CourseCubit>().switchCourse();
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => CourseSelectScreen(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        'החלף קורס',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
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
