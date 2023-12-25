// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return numericDates ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return numericDates ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String toMonthDateYear() {
    final date = DateFormat('MMM dd, yyyy').format(this);
    return date;
  }

  String toDateMonthYear() {
    final date = DateFormat('dd.MM.yyyy hh:mm').format(this);
    return date;
  }

  String toDateMonthYearInSlashes() {
    final date = DateFormat('dd/MM/yyyy').format(this);
    return date;
  }

  String toMMMdd() {
    final date = DateFormat('MMM dd').format(this);
    return date;
  }

  bool areDaysEqual({required DateTime to}) {
    final from = DateTime(year, month, day);
    to = DateTime(to.year, to.month, to.day);
    if (from == to) {
      return true;
    } else {
      return false;
    }
  }

  DateTime addCalendarDays(int numDays) => copyWith(day: day + numDays);
}
