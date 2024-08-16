import 'package:talker_flutter/talker_flutter.dart';

class CustomLog extends TalkerLog {
  final String text;
  final int color;
  CustomLog(String super.message, this.text, this.color);

  @override
  String get title => text;

  @override
  AnsiPen get pen => AnsiPen()..xterm(color);
}