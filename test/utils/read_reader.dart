import 'dart:io';

String readJsonFile(String fname) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) dir = dir.replaceAll('/test', '');
  return File('$dir/test/$fname').readAsStringSync();
}
