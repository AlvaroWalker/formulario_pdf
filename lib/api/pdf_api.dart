import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf_merger/pdf_merger.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    String? name2,
    required Document pdf,
    Document? pdf2,
  }) async {
    final bytes = await pdf.save();
    final bytes2 = await pdf2!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    final file2 = File('${dir.path}/$name2');

    await file.writeAsBytes(bytes);
    await file2.writeAsBytes(bytes2);

    await PdfMerger.mergeMultiplePDF(
        paths: [file.path, file2.path], outputDirPath: '${dir.path}/final.pdf');

    return File('${dir.path}/final.pdf');
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
