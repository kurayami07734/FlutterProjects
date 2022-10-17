import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  var file = await picker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  throw Exception("No file picked");
}
