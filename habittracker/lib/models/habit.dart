import 'package:isar_community/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  // Habit id
  Id id = Isar.autoIncrement;

  // Habit Name
  late String name;

  // Completed Days
  List<DateTime> completedDays = [];
}
