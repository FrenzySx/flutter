import 'package:habittracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

// prepare heat map dataset
Map<DateTime, int> prepHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      // normalize date to avoid time mismatch
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // if the date already exist in the dataset, increment its count
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        // initialize it with count of 1
        dataset[normalizedDate] = 1;
      }
    }
  }

  return dataset;
}
