import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/app_config.dart';

/// JS channel the page's `window.print()` posts the printout's HTML to.
const mebelPrintChannel = 'AndozaPrint';

/// JS channel a CSV download is posted to, as `{"name": …, "text": …}`.
const mebelDownloadChannel = 'AndozaDownload';

/// Run after every page load. A WebView does nothing on `window.print()` and
/// on a `<a download href="blob:…">` click, which is how the web mebel page
/// prints (PDF) and exports its CSV (`features/mebel/export/csv.ts`); this
/// hands both to the app instead. The blob is read at click time, before the
/// page revokes it.
const mebelBridgeJs = '''
(function () {
  if (window.__andozaBridge) return;
  window.__andozaBridge = true;
  window.print = function () {
    var doc = document.documentElement.cloneNode(true);
    doc.querySelectorAll('script').forEach(function (s) { s.remove(); });
    $mebelPrintChannel.postMessage('<!doctype html>' + doc.outerHTML);
  };
  var click = HTMLAnchorElement.prototype.click;
  HTMLAnchorElement.prototype.click = function () {
    if (this.download && this.href.indexOf('blob:') === 0) {
      var name = this.download;
      fetch(this.href).then(function (r) { return r.text(); }).then(function (text) {
        $mebelDownloadChannel.postMessage(JSON.stringify({ name: name, text: text }));
      });
      return;
    }
    return click.call(this);
  };
})();
''';

/// A CSV the page handed over: its file name and text.
typedef MebelCsv = ({String name, String text});

/// The CSV in a [mebelDownloadChannel] message, or null if it is not one.
MebelCsv? parseMebelCsv(String message) {
  try {
    final json = jsonDecode(message);
    if (json is! Map) return null;
    final name = json['name'];
    final text = json['text'];
    if (name is! String || text is! String) return null;
    return (name: name, text: text);
  } catch (_) {
    return null;
  }
}

/// [name] safe as a file name, ending in `.csv`.
String mebelCsvFileName(String name) {
  final base = name.replaceAll(RegExp(r'[\\/:*?"<>|]+'), '_').trim();
  final safe = base.isEmpty ? 'cut-list' : base;
  return safe.toLowerCase().endsWith('.csv') ? safe : '$safe.csv';
}

/// Writes the CSV to a temporary file and opens the share sheet. The text
/// already starts with a UTF-8 byte-order mark, so Excel reads Cyrillic.
Future<void> shareMebelCsv(MebelCsv csv) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${mebelCsvFileName(csv.name)}');
  await file.writeAsString(csv.text, encoding: utf8, flush: true);
  await Share.shareXFiles([XFile(file.path, mimeType: 'text/csv')]);
}

/// Opens the system print dialog (with "Save as PDF") for the page's
/// printout. Its stylesheets load from the studio origin, so the print
/// layout (A4 landscape) applies.
///
/// `convertHtml` is marked deprecated but still maintained on Android and iOS
/// (5.15.1 fixed it for iOS 26); it is the one way to print a page that only
/// exists inside a WebView.
Future<void> printMebelHtml(String html) {
  return Printing.layoutPdf(
    name: 'Andoza mebel',
    // ignore: deprecated_member_use
    onLayout: (format) => Printing.convertHtml(
      html: html,
      baseUrl: AppConfig.studioBaseUrl,
      format: format,
    ),
  );
}
