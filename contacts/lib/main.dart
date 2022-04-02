import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var totalContact = 2;
  var name = ["안수진", "정한비"];

  addNewContact() {
    setState(() {
      totalContact++;
    });
  }

  getName(inputData) {
    setState(() {
      name.add(inputData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(addNewContact: addNewContact, getName: getName);
              });
        },
      ),
      appBar: AppBar(
        leading: Text(
          totalContact.toString(),
        ),
        title: Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, i) {
          return ListTile(
              title: Text(name[i].toString()),
              trailing:
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)));
        },
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addNewContact, this.getName}) : super(key: key);
  final addNewContact;
  final getName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            children: [
              TextField(
                controller: inputData,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    addNewContact();
                    getName(inputData.text);
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          )),
    );
  }
}
