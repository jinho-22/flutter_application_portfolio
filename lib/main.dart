import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'my_timer.dart';
import 'my_dice_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  // 하단 아이템들 배열
  List<BottomNavigationBarItem> items = [];
  late Widget bodyPage;
  List<dynamic> pages = [
    const MyTimer(),
    const MyTimer(),
    const MyDice(),
    const MyTimer(),
  ];

  void movePage(int page) {
    setState(() {
      _index = page;
      bodyPage = pages[page];
    });
  }

  @override
  void initState() {
    super.initState();
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.home), label: '홈', backgroundColor: Colors.red));
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.access_time_rounded),
        label: '타이머',
        backgroundColor: Colors.blue));
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.checklist_rounded),
        label: '뽑기',
        backgroundColor: Colors.green));
    items.add(const BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.comment),
        label: '소개',
        backgroundColor: Colors.yellow));

    bodyPage = const Center(child: FaIcon(FontAwesomeIcons.user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: bodyPage,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              movePage(value);
            },
            currentIndex: _index,
            // type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.green,
            items: items),
      ),
    );
  }
}
