import 'package:flutter/material.dart';
import 'package:habittracker/database/habit_database.dart';
import 'package:habittracker/pages/home_page.dart';
import 'package:habittracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  final habitDatabase = HabitDatabase();
  await habitDatabase.saveFirstLaunchDate();
  final isDark = await habitDatabase.getDarkMode();
  runApp(
    MultiProvider(
      providers: [
        // habit provider
        ChangeNotifierProvider.value(value: habitDatabase),

        // theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            isDark: isDark,
            onChanged: habitDatabase.saveDarkMode,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
