import 'package:flutter/material.dart';
import 'package:note_app/models/note_database.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/pages/settings_page.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize isar note database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  final isDark = await NoteDatabase.getDarkMode();

  runApp(
    MultiProvider(
      providers: [
        // Note Provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        // Theme Provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            isDark: isDark,
            onChanged: NoteDatabase.saveDarkMode,
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
      home: NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/note_page': (context) => NotesPage(),
        '/settings_page': (context) => SettingsPage(),
      },
    );
  }
}
