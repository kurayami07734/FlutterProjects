import 'package:firstfire/services/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/cloud/cloud_note.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import './notes_list_view.dart';
import '../../services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import '../../utils/dialogs/logout_dialog.dart';
import '../../enums/menu_actions.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;

  String get userId => AuthService.fromFirebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    // if (!_notesService.isDbOpen()) _notesService.open();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _notesService.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuActions>(
            onSelected: (e) async {
              switch (e) {
                case MenuActions.logout:
                  final shouldLogout = await showLogoutDialog(
                    context: context,
                  );
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                  value: MenuActions.logout,
                  child: Text("Logout"),
                )
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              {
                if (snapshot.hasData) {
                  final notes = snapshot.data as Iterable<CloudNote>;
                  // print(notes);
                  // return Text("got the notes");
                  return NotesListView(
                      notes: notes,
                      onTap: ((note) {
                        Navigator.of(context).pushNamed(
                          createUpdateNoteRoute,
                          arguments: note,
                        );
                      }),
                      onDeleteNote: (note) async {
                        await _notesService.deleteNote(
                          documentId: note.documentId,
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
