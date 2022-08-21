import '../../services/crud/database_note.dart';
import '../../services/crud/notes_service.dart';
import '../../services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import '../../utils/show_logout_dialog.dart';
import '../../enums/menu_actions.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String get userEmail => AuthService.fromFirebase().currentUser!.email!;
  late final NotesService _notesService;

  @override
  void initState() {
    _notesService = NotesService();
    if (!_notesService.isDbOpen()) _notesService.open();
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
              Navigator.of(context).pushNamed(newNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuActions>(
            onSelected: (e) async {
              switch (e) {
                case MenuActions.logout:
                  final shouldLogout = await showLogoutDialog(context: context);
                  if (shouldLogout) {
                    AuthService.fromFirebase().logout();
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
      body: FutureBuilder(
          future: _notesService.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                  stream: _notesService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        {
                          if (snapshot.hasData) {
                            final notes = snapshot.data as List<DatabaseNote>;
                            // print(notes);
                            // return Text("got the notes");
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
                                  );
                                });
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      default:
                        return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
