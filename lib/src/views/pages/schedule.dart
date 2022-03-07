import 'dart:convert';
import 'package:edt_isen/src/api/aurion.dart';
import 'package:edt_isen/src/common/create_route.dart';
import 'package:edt_isen/src/common/progress_hud_wrapper.dart';
import 'package:edt_isen/src/common/schedule.dart';
import 'package:edt_isen/src/utils/secure_storage.dart';
import 'package:edt_isen/src/views/components/schedule/components/schedule_appbar.dart';
import 'package:edt_isen/src/views/components/schedule/components/user_info_drawer.dart';
import 'package:edt_isen/src/views/components/schedule/components/week_table.dart';
import 'package:edt_isen/src/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  final List<dynamic>? schedule;

  const ScheduleScreen({Key? key, this.schedule}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late List<dynamic> _schedule;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _isCalendarOpen = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    if (widget.schedule != null) {
      _schedule = widget.schedule!;
    } else {
      SecureStorage.getSchedule()
          .then((value) => _schedule = json.decode(value ?? "[]"));
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showCalendarState() async {
    _isCalendarOpen = _animationController.status == AnimationStatus.completed;
    if (_isCalendarOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _calendarFormat =
          _isCalendarOpen ? CalendarFormat.week : CalendarFormat.month;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScheduleAppBar(
          animationController: _animationController,
          showCalendarState: _showCalendarState,
          focusedDay: _focusedDay,
        ),
        body: Column(children: [
          WeekTable(
            locale: locale,
            firstDay: firstDay,
            lastDay: lastDay,
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            startingDayOfWeek: startingDayOfWeek,
            calendarFormat: _calendarFormat,
            onDaySelected: _onDaySelected,
            onPageChanged: _onPageChanged,
          ),
        ]),
        endDrawer: const UserInfoDrawer(),
    );
  }
}
