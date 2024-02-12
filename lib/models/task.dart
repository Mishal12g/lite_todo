import 'package:hive_flutter/hive_flutter.dart';

part "task.g.dart";

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String text;

  @HiveField(1)
  bool isCompleted = false;

  Task({required this.text});
}
