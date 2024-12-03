import 'package:intl/intl.dart';

class Formatter {
  static String convertSex(bool? sex) {
    return switch (sex) {
      true => 'Мужской',
      false => 'Женский',
      null => 'Не выбрано',
    };
  }

  static String convertDateOfBirth(String dateOfBirthday) {
    try {
      final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
      final date = dateFormat.parseUTC(dateOfBirthday);
      return '${date.day}.${date.month}.${date.year}';
    }
    catch (e, trace) {
      print(e);
      print(trace);
      return '';
    }
  }
}