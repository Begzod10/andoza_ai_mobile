import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Writes raw PDF [bytes] to a temporary file and opens the system share sheet
/// so the user can save/print/send the smeta. Returns the file path written.
///
/// Kept UI-free so it can be called from any screen and unit-reasoned about;
/// the caller handles snackbars/errors.
Future<String> sharePdfBytes(
  List<int> bytes, {
  required String fileName,
  String? shareText,
}) async {
  final dir = await getTemporaryDirectory();
  final safeName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';
  final file = File('${dir.path}/$safeName');
  await file.writeAsBytes(bytes, flush: true);

  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'application/pdf')],
    text: shareText,
  );
  return file.path;
}
