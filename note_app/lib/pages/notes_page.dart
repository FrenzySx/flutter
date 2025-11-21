import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/components/drawer.dart';
import 'package:note_app/components/note_tile.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  // Create a note

  @override
  void initState() {
    super.initState();

    readNotes();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void closeDialog() {
    textController.clear();
    Navigator.pop(context);
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(controller: textController),
        actions: [
          MaterialButton(onPressed: closeDialog, child: const Text('Cancel')),
          MaterialButton(
            onPressed: () {
              final text = textController.text.trim();
              if (text.isNotEmpty) context.read<NoteDatabase>().addNote(text);
              closeDialog();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // Read a note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // Update a note

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Update Note'),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(onPressed: closeDialog, child: const Text('Cancel')),
          MaterialButton(
            onPressed: () {
              final text = textController.text.trim();
              if (text.isNotEmpty) {
                context.read<NoteDatabase>().updateNote(note.id, text);
              }
              closeDialog();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // Delete a note

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        //title: const Text('Notes'),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20),
            child: Text(
              'Notes',
              style: GoogleFonts.playfairDisplay(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // List of Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
