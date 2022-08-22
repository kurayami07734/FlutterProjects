import 'package:flutter/foundation.dart';

@immutable
class CloudStoreException implements Exception {
  const CloudStoreException();
}

class CouldNotCreateNoteException extends CloudStoreException {}

class CouldNotGetAllNotesException extends CloudStoreException {}

class CouldNotUpdateNoteException extends CloudStoreException {}

class CouldNotDeleteNoteException extends CloudStoreException {}
