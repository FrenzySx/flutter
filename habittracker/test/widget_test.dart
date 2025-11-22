import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/util/habit_util.dart';

void main() {
  test('isHabitCompletedToday ignores time of day', () {
    final now = DateTime.now();
    expect(isHabitCompletedToday([]), false);
    expect(
      isHabitCompletedToday([DateTime(now.year, now.month, now.day, 23, 59)]),
      true,
    );
    expect(
      isHabitCompletedToday([now.subtract(const Duration(days: 1))]),
      false,
    );
  });

  test('prepHeatMapDataset counts per normalized day', () {
    final a = Habit()
      ..name = 'a'
      ..completedDays = [DateTime(2024, 1, 1, 8), DateTime(2024, 1, 2)];
    final b = Habit()
      ..name = 'b'
      ..completedDays = [DateTime(2024, 1, 1, 20)];
    final m = prepHeatMapDataset([a, b]);
    expect(m[DateTime(2024, 1, 1)], 2);
    expect(m[DateTime(2024, 1, 2)], 1);
  });
}
