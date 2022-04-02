import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = 'Contacts App';
  var contactNames = ["안수진", "정한비", "류가형"];
  var liked = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Text(a.toString()),
            onPressed: () {
              setState(() {
                a++;
              });
            },
          ),
          appBar: AppBar(
            title: Text(name),
          ),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Text(liked[i].toString()),
                title: Text(contactNames[i]),
                trailing: IconButton(
                  icon: Icon(Icons.favorite_outline_rounded),
                  onPressed: () {
                    setState(() {
                      liked[i]++;
                    });
                  },
                ),
              );
            },
          )
        ),
    );
  }
}

