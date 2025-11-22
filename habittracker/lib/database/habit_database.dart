import 'package:flutter/material.dart';
import 'package:habittracker/models/app_settings.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // SETUP

  //  INITIALIZE DATABASE

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  // SAVE FIRST DATE OF APP STARTUP

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // GET FIRST DATE OF APP STARTUP
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  Future<bool> getDarkMode() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.isDarkMode ?? true;
  }

  Future<void> saveDarkMode(bool isDark) async {
    final settings =
        await isar.appSettings.where().findFirst() ?? AppSettings();
    settings.isDarkMode = isDark;
    await isar.writeTxn(() => isar.appSettings.put(settings));
  }

  // CRUD OPERATIONS

  // LIST OF HABITS
  final List<Habit> currentHabits = [];

  // CREATE - ADD NEW HABITS
  Future<void> addHabit(String habitName) async {
    // CREATE HABIT
    final newHabit = Habit()..name = habitName;

    // SAVE TO DB
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // RE-READ FROM DB
    await readHabits();
  }

  // READ - READ SAVED HABITS FROM DB
  Future<void> readHabits() async {
    // FETCH ALL HABITS FROM DB
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // GIVE TO CURRENT HABITS
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // UPDATE UI
    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final days = habit.completedDays
          .where((d) => DateTime(d.year, d.month, d.day) != today)
          .toList();
      if (isCompleted) days.add(today);
      habit.completedDays = days;
      await isar.writeTxn(() => isar.habits.put(habit));
    }
    await readHabits();
  }

  // UPDATE - EDIT HABIT NAME
  Future<void> updateHabitName(int id, String newName) async {
    // find the specifi habit
    final habit = await isar.habits.get(id);

    // update habit name
    if (habit != null) {
      // update name
      await isar.writeTxn(() async {
        habit.name = newName;
        // SAVE UPDATED HABIT back to the db
        await isar.habits.put(habit);
      });
    }

    await readHabits();
  }

  // DELETE - DELETE HABIT
  Future<void> deleteHabit(int id) async {
    // perform the delete
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // re read
    await readHabits();
  }
}
