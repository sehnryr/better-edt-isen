import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekTable extends StatelessWidget {
  final String locale;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final StartingDayOfWeek startingDayOfWeek;
  final CalendarFormat calendarFormat;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(DateTime) onPageChanged;

  const WeekTable(
      {Key? key,
      required this.locale,
      required this.firstDay,
      required this.lastDay,
      required this.selectedDay,
      required this.focusedDay,
      required this.startingDayOfWeek,
      required this.calendarFormat,
      required this.onDaySelected,
      required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: Theme.of(context).appBarTheme.elevation ?? 4.0,
      child: TableCalendar(
        headerVisible: false,
        locale: locale,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay,
        startingDayOfWeek: startingDayOfWeek,
        calendarFormat: calendarFormat,
        onDaySelected: onDaySelected,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
        ),
        onPageChanged: onPageChanged,
      ),
    );
  }
}
