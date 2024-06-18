import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'colors.dart'; // Ensure your colors.dart file contains the definitions for `tacao` and `azalea`

class Note {
  final int id;
  final int userId;
  final String date;
  final String content;
  final String mood; // Added mood field
  final List<String> tags;

  Note({
    required this.id,
    required this.userId,
    required this.date,
    required this.content,
    required this.mood,
    required this.tags,
  });

  Note copyWith({
    int? id,
    int? userId,
    String? date,
    String? content,
    String? mood,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      tags: tags ?? this.tags,
    );
  }
}

class NotitiePage extends StatefulWidget {
  const NotitiePage({super.key});

  @override
  _NotitiePageState createState() => _NotitiePageState();
}

class _NotitiePageState extends State<NotitiePage> {
  final TextEditingController _contentController = TextEditingController();
  List<Note> notes = []; // List to hold notes
  String _mood = ''; // Variable to hold the user's mood selection
  Note? _editingNote; // Variable to hold the note being edited

  void _addOrUpdateNote() {
    // Use the current date
    final String currentDate = DateTime.now().toIso8601String().split('T').first;

    if (_contentController.text.isNotEmpty && _mood.isNotEmpty) {
      if (_editingNote != null) {
        // Update existing note
        Note updatedNote = _editingNote!.copyWith(
          content: _contentController.text,
          mood: _mood,
          date: currentDate,
        );
        setState(() {
          int index = notes.indexOf(_editingNote!);
          notes[index] = updatedNote;
          _editingNote = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note updated successfully')),
        );
      } else {
        // Add new note
        Note newNote = Note(
          id: notes.length + 1, // Generating a simple ID (replace with actual logic)
          userId: 1, // Example user ID
          date: currentDate,
          content: _contentController.text,
          mood: _mood,
          tags: [], // Empty list for tags
        );

        setState(() {
          notes.add(newNote); // Add new note to the list
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note added successfully')),
        );
      }

      _contentController.clear();
      _mood = '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter content and select your mood')),
      );
    }
  }

  void _showAddOrEditNoteDialog([Note? note]) {
    if (note != null) {
      _contentController.text = note.content;
      _mood = note.mood;
      _editingNote = note;
    } else {
      _contentController.clear();
      _mood = '';
      _editingNote = null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(note == null ? 'New Note' : 'Edit Note'),
              backgroundColor: azalea, // Set background color of AlertDialog
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'How was your day?',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up, color: _mood == 'good' ? tacao : Colors.grey),
                          onPressed: () {
                            setState(() {
                              _mood = 'good';
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_down, color: _mood == 'bad' ? tacao : Colors.grey),
                          onPressed: () {
                            setState(() {
                              _mood = 'bad';
                            });
                          },
                        ),
                      ],
                    ),
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter content',
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: tacao,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: tacao, // Background color for Add button
                    ),
                    child: Text(
                      note == null ? 'Add' : 'Update',
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _addOrUpdateNote();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: tacao,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: notes.isEmpty
                ? const Center(
              child: Text(
                'No notes available',
                style: TextStyle(fontSize: 24),
              ),
            )
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(notes[index].id.toString()),
                  onDismissed: (direction) {
                    _deleteNote(index);
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(notes[index].content),
                      subtitle: Text('${notes[index].date} - Mood: ${notes[index].mood}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showAddOrEditNoteDialog(notes[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditNoteDialog(),
        backgroundColor: tacao,
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
