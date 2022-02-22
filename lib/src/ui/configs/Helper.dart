import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

Future<List<List<String>>> readCSV(String type) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv', 'xls', 'xlsx'],
  );
  // if (result == null) return;
  final file = result.files.first;
  final uploadedFile = String.fromCharCodes(file.bytes);
  List<List<String>> rowsAsListOfValues = const CsvToListConverter()
      .convert(uploadedFile, shouldParseNumbers: false);
  print(rowsAsListOfValues);
  return rowsAsListOfValues;
}
