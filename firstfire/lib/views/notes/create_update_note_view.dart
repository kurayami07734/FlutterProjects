import '../../utils/generics/get_argument.dart';
import '../../services/auth/auth_service.dart';
import '../../services/crud/notes_service.dart';
import 'package:flutter/material.dart';
import '../../services/crud/database_note.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  @override
  void initState() {
    _noteService = NotesService();
    _textEditingController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) return;
    final text = _textEditingController.text;
    await _noteService.updateNotes(
      note: note,
      text: text,
    );
  }

  DatabaseNote? _note;
  late final NotesService _noteService;
  late final TextEditingController _textEditingController;

  Future<DatabaseNote> createOrGetExistingNote() async {
    final widgetNote = context.getArgument<DatabaseNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textEditingController.text = widgetNote.text;
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) return existingNote;
    final currentUser = AuthService.fromFirebase().currentUser!;
    final email = currentUser.email;
    final owner = await _noteService.getUser(email: email);
    final newNote = await _noteService.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfEmpty() {
    final note = _note;
    if (_textEditingController.text.isEmpty && note != null) {
      _noteService.deleteNote(noteId: note.id);
    }
  }

  void _saveNoteIfNotEmpty() async {
    final note = _note;
    final text = _textEditingController.text;
    if (note != null && text.isNotEmpty) {
      await _noteService.updateNotes(
        note: note,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfEmpty();
    _saveNoteIfNotEmpty();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                _textControllerListener();
                return TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Text goes here (Notes are auto saved)",
                  ),
                );
              }
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
