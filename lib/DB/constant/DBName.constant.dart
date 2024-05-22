import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<String> DBname() async {
  return await join(await getDatabasesPath(), 'Texthub.db');
}
