import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_penguin_dictionary/src/model.dart';

List<PenguinModel> penguinProfiles = [];
String fontFamilyCommon = 'WDXLLubrifontJPN';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var mainViewController = PageController();

  var imgControllerCurrent = 0;
  var imgController = PageController(viewportFraction: 1, initialPage: 0);

  var penguinIndex = 0;

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (imgControllerCurrent < penguinProfiles[penguinIndex].images.length) {
        imgControllerCurrent++;
      } else {
        imgControllerCurrent = 0;
      }

      imgController.animateToPage(
        imgControllerCurrent,
        duration: Duration(milliseconds: 2000),
        curve: Curves.linearToEaseOut,
      );
    });
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    double appBarText = deviceWidth < deviceHeight
        ? deviceWidth * 0.06
        : deviceHeight * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "ポケットペンギン図鑑",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: appBarText,
              fontFamily: fontFamilyCommon,
            ),
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

      // PageViewの中身
      // 縦方向にその種のペンギンの画像
      // Low
      //  左ボタン
      //  ペンギン名称
      //  右ボタン
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: deviceHeight * 0.01),
            SizedBox(
              height: deviceHeight > deviceWidth
                  ? deviceWidth * 0.9
                  : deviceHeight * 0.6,
              // color: Colors.black,
              child: PageView(
                padEnds: false,
                controller: imgController,
                scrollDirection: Axis.vertical,
                children: penguinProfiles[penguinIndex].images
                    .map(
                      (e) => Image.asset(
                        e,
                        width: deviceHeight > deviceWidth
                            ? deviceWidth * 0.9
                            : deviceHeight * 0.6,
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // 前のペンギンへ
                      penguinIndex--;
                      if (0 > penguinIndex) {
                        penguinIndex = penguinProfiles.length - 1;
                      }
                      imgControllerCurrent = 0;
                      setState(() {
                        print(penguinIndex);
                        print(penguinProfiles[penguinIndex].penguin);
                      });
                    },
                    icon: Icon(Icons.chevron_left),
                    iconSize: deviceWidth * 0.07,
                  ),
                  Text(
                    penguinProfiles[penguinIndex].penguin,
                    style: TextStyle(
                      fontFamily: fontFamilyCommon,
                      fontSize: deviceHeight > deviceWidth
                          ? deviceHeight * 0.02
                          : deviceWidth * 0.05,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // 次のペンギンへ

                      if (penguinIndex < penguinProfiles.length - 1) {
                        penguinIndex++;
                      } else {
                        penguinIndex = 0;
                      }
                      imgControllerCurrent = 0;
                      setState(() {
                        print(penguinIndex);
                        print(penguinProfiles[penguinIndex].penguin);
                      });
                    },
                    icon: Icon(Icons.chevron_right),
                    iconSize: deviceWidth * 0.07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
