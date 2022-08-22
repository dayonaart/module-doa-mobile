import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import 'package:open_pdf/open_pdf.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File(appDocPath + '/' + '$fileName.pdf');
  print('Save as file ${file.path} ...');
  await file.writeAsBytes(bytes, mode: FileMode.append);
  var _pdfPage = SfPdfViewer.file(file);
  Get.to(_pdfPage);
}

Future<void> downloadDirectory(List<int> bytes, String filename) async {
  Directory downloadsDirectory;
  downloadsDirectory = (await DownloadsPathProvider.downloadsDirectory)!;
  final appDocPath = '${downloadsDirectory.path}/$filename.pdf';
  print('${appDocPath}');
  final fileDownload = File(appDocPath);

  // await file.writeAsBytes(bytes, mode: FileMode.append);
  await fileDownload.writeAsBytes(bytes, mode: FileMode.append);
  var _pdfPage = SfPdfViewer.file(fileDownload);
  Get.to(_pdfPage);
  // var result = await OpenPdf().openPDF(path: appDocPath);
  // Get.to(result);
}
