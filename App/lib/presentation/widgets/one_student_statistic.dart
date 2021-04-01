import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class OneStudentStatistic extends StatelessWidget {
  final int value;
  final String title;

  OneStudentStatistic({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  AnimationController? _animationController;

  @override
  Widget build(BuildContext context) {
    _animationController?.forward(from: 0.0);
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            manualTrigger: true,
            controller: (controller) => _animationController = controller,
            child: Text(
              value.toString(),
              style: textStyle!
                  .copyWith(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            title,
            style: textStyle.copyWith(fontSize: 15, height: 1),
          )
        ],
      ),
    );
  }
}
