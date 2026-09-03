import 'package:file_picker/file_picker.dart';

Future<List<int>?> readPickedFileBytes(PlatformFile file) async {
  return file.bytes;
}
