import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/settings.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  // INITIALIZE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema, SettingsSchema], directory: dir.path);
  }

  static Future<bool> getDarkMode() async =>
      (await isar.settings.get(0))?.isDarkMode ?? false;

  static Future<void> saveDarkMode(bool isDark) =>
      isar.writeTxn(() => isar.settings.put(Settings()..isDarkMode = isDark));

  // List of notes

  final List<Note> currentNotes = [];

  // CREATE

  Future<void> addNote(String textFromUser) async {
    // Create new note object
    final newNote = Note()..text = textFromUser;

    // save to db

    await isar.writeTxn(() => isar.notes.put(newNote));

    // re read from db

    await fetchNotes();
  }

  // READ
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // UPDATE
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // DELETE

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
