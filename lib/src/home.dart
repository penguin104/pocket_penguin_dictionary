import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_penguin_dictionary/src/model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<PenguinModel> penguinProfiles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    print(penguinProfiles);
  }

  Future<void> init() async {
    final jsonData = jsonDecode(
      await rootBundle.loadString("assets/data/penguin_kind.json"),
    );

    // print(await rootBundle.loadString("assets/data/penguin_kind.json"));
    // print("111");

    setState(() {
      penguinProfiles = jsonData
          .map<PenguinModel>((e) => PenguinModel.fromJson(e))
          .toList();
      // print(penguinProfiles[0].images[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "ポケットペンギン図鑑",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            print("show lists");
          },
          icon: Icon(Icons.list, size: 50),
        ),
        backgroundColor: Colors.lightBlue[200],
        foregroundColor: Colors.blue[900],
        toolbarHeight: 100,
      ),
      body: MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //contents
        ],
      ),
    );
  }
}
