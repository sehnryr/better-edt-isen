import 'package:table_calendar/table_calendar.dart';

const String locale = "fr_FR";
final DateTime firstDay =
    DateTime.now().subtract(Duration(days: 1 * 7 + DateTime.now().weekday));
final DateTime lastDay = DateTime(DateTime.now().year, DateTime.june, 30);
const StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.sunday;