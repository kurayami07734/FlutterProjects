import 'package:flutter/material.dart';
import '../../services/crud/database_note.dart';
import '../../utils/dialogs/delete_dialog.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;
  const NotesListView(
      {Key? key, required this.notes, required this.onDeleteNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context: context);
                if (shouldDelete) onDeleteNote(note);
              },
            ),
          );
        });
  }
}
