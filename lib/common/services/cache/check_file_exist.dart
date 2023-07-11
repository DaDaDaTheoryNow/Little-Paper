import 'dart:io';

bool checkFileExists(String filePath) {
  File file = File(filePath);
  return file.existsSync();
}
