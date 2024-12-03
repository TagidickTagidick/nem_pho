class Formatter {
  static String convertSex(bool? sex) {
    return switch (sex) {
      true => 'Мужской',
      false => 'Женский',
      null => 'Не выбрано',
    };
  }

  static String convertDateOfBirth(String dateOfBirthday) {
    final DateTime date = DateTime.parse(dateOfBirthday);
    return '${date.day}.${date.month}.${date.year}';
  }
}