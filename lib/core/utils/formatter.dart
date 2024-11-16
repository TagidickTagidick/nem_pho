class Formatter {
  static String convertSex(bool? sex) {
    return switch (sex) {
      true => 'Мужской',
      false => 'Женский',
      null => 'Не выбрано',
    };
  }
}