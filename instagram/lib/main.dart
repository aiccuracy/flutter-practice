import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (result.statusCode == 200) {
      setState(() {
        data = jsonDecode(result.body);
      });
    } else {
      print("GET Data Failed");
      data = [];
    }
  }

  addData(a) {
    setState(() {
      data.add(a);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
                onTap: () {}, child: Icon(Icons.add_box_outlined)),
          ),
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
                onTap: () {}, child: Icon(Icons.favorite_border_outlined)),
          ),
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child:
                GestureDetector(onTap: () {}, child: Icon(Icons.chevron_right)),
          ),
        ],
      ),
      body: [
        InstaContents(data: data, addData: addData),
        Text("Shop Page")
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'Shop'),
        ],
      ),
    );
  }
}

class InstaContents extends StatefulWidget {
  const InstaContents({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData;

  @override
  State<InstaContents> createState() => _InstaContentsState();
}

class _InstaContentsState extends State<InstaContents> {
  var scroll = ScrollController();
  var moreResult = [];

  getMoreData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      print(widget.data);
      return ListView.builder(
        itemCount: widget.data.length,
        controller: scroll,
        itemBuilder: (context, idx) {
          return Column(
            children: [
              Column(
                children: [
                  Image.asset('img1.jpg'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border_outlined)),
                      Text(widget.data[idx]["likes"].toString()),
                    ],
                  ),
                  Text(widget.data[idx]['user']),
                  Text(widget.data[idx]['content'])
                ],
              )
            ],
          );
        },
      );
    } else {
      return Text("Loading...");
    }
  }
}
