import 'package:intl/intl.dart';

class FormatDate {
  static DateTime parse(String date) => DateFormat('y-MM-DD').parse(date);
  static String format(DateTime date) => DateFormat('y-MM-dd').format(date);
}
