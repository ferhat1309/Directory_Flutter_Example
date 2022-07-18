import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:convert';
import 'directory.dart';
import 'directorydao.dart';

TextEditingController name = TextEditingController();
TextEditingController number = TextEditingController();

class Directory_main extends StatefulWidget {
  const Directory_main({Key? key}) : super(key: key);

  @override
  State<Directory_main> createState() => _Directory_mainState();
}

class _Directory_mainState extends State<Directory_main> {
  @override
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<String> numbers = <String>['1', '2', '3'];

  Future<List<Directory>> getalldirectory() async {
    return await DirectoryDao().getalldirectory();
  }

  Future<void> Deletedirectory(int directory_id) async {
    await DirectoryDao().deletedirectory(directory_id);
    setState(() {});
  }

  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REHBER"),
      ),
      body: FutureBuilder<List<Directory>>(
          future: getalldirectory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var all_directory = snapshot.data;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: all_directory?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.account_circle)),
                        Expanded(
                            flex: 2,
                            child: Text('${all_directory?[index].name}')),
                        Expanded(
                            flex: 2,
                            child: Text('${all_directory?[index].number}')),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                var id = int.tryParse('${all_directory?[index].id}');
                                if (id is int){
                                  Deletedirectory(id);
                                }
                                setState(() {});
                              },
                            ))
                      ],
                    ), //Center(child: Text('Entry ${entries[index]}'))
                  );
                },
              );
            } else {
              return Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Yeni Kayıt"),
                content: SizedBox(
                  height: 100,
                  child: Column(children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(hintText: "İsim"),
                    ),
                    TextField(
                      controller: number,
                      decoration: InputDecoration(hintText: "Numara"),
                    ),
                  ]),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Geri"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      name.text = "";
                      number.text = "";
                    },
                  ),
                  new FlatButton(
                    child: new Text("Kaydet"),
                    onPressed: () {
                      adddirectory(name.text, number.text);
                      setState(() {
                      });
                      name.text = "";
                      number.text = "";
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _AddAccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Yeni Kayıt"),
        content: SizedBox(
          height: 100,
          child: Column(children: [
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: "İsim"),
            ),
            TextField(
              controller: number,
              decoration: InputDecoration(hintText: "Numara"),
            ),
          ]),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Geri"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Kaydet"),
            onPressed: () {
              adddirectory(name.text, number.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> adddirectory(String name, String number) async {
  await DirectoryDao().adddirectory(name, number);
}
