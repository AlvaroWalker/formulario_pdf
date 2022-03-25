import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Uint8List pdf,
  }) async {
    final bytes = pdf;

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return File('${dir.path}/$name');
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
