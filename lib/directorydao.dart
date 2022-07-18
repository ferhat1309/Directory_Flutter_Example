import 'package:example1/DatabaseController.dart';
import 'package:example1/directory.dart';

class DirectoryDao{

  Future<List<Directory>> getalldirectory() async {
    var db = await DatabaseController.ConnectDatabase();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM directory_table");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Directory( row["id"], row["name"], row["number"]);

    });
  }

  Future<void> adddirectory(String name,String number) async {
    var db = await DatabaseController.ConnectDatabase();

    var values = Map<String,dynamic>();
    values["name"] = name;
    values["number"] = number;

    await db.insert("directory_table", values);
  }

  Future<void> deletedirectory(int directory_id) async {
    var db = await DatabaseController.ConnectDatabase();
    await db.delete("directory_table",where: "id=?",whereArgs: [directory_id]);
  }
}