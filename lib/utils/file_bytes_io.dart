import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<List<int>?> readPickedFileBytes(PlatformFile file) async {
  if (file.bytes != null) {
    return file.bytes!;
  }
  if (file.path != null) {
    return File(file.path!).readAsBytes();
  }
  return null;
}
