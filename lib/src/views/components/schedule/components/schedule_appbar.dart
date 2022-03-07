import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:edt_isen/src/common/schedule.dart';

class ScheduleAppBar extends StatelessWidget with PreferredSizeWidget{
  final void Function() showCalendarState;
  final AnimationController animationController;
  final DateTime focusedDay;

  const ScheduleAppBar(
      {Key? key,
      required this.showCalendarState,
      required this.animationController,
      required this.focusedDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: InkWell(
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          height: AppBar().preferredSize.height,
          child: Row(
            children: [
              Text(
                toBeginningOfSentenceCase(
                    DateFormat.MMMM(locale).format(focusedDay))!,
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: -0.5)
                    .chain(CurveTween(curve: Curves.easeInOut))
                    .animate(animationController),
                child: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
        onTap: showCalendarState,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
