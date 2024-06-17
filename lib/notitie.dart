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

  void _addNote() {
    // Use the current date
    final String currentDate = DateTime.now().toIso8601String().split('T').first;

    if (_contentController.text.isNotEmpty && _mood.isNotEmpty) {
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

      _contentController.clear();
      _mood = '';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter content and select your mood')),
      );
    }
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Note'),
          backgroundColor: azalea, // Set background color of AlertDialog
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
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
                        Navigator.of(context).pop();
                        _showAddNoteDialog(); // Re-open dialog to update state
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.thumb_down, color: _mood == 'bad' ? tacao : Colors.grey),
                      onPressed: () {
                        setState(() {
                          _mood = 'bad';
                        });
                        Navigator.of(context).pop();
                        _showAddNoteDialog(); // Re-open dialog to update state
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

              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: tacao, // Background color for Add button
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _addNote();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
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
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: notes.isEmpty
                ? Center(
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddNoteDialog,
        backgroundColor: tacao,
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
