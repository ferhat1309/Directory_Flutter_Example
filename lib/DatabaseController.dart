
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController{

  static final String DatabaseName = "directory_table.db";

  static Future<Database> ConnectDatabase() async {
    String DatabasePath = join(await getDatabasesPath(), DatabaseName);

    if(await databaseExists(DatabasePath)){
    }else{
      ByteData data = await rootBundle.load("database/$DatabaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(DatabasePath).writeAsBytes(bytes,flush: true);
    }
    return openDatabase(DatabasePath);
  }

}



