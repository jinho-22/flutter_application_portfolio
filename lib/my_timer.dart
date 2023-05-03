import 'dart:async';

import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  // int totalTime = 60;
  int times = 60;
  late Timer timer;
  String timeView = '0:00:00';
  bool isRunning = false;

  void timeStart() {
    if (isRunning) {
      timeStop();
      setState(() {
        isRunning = !isRunning;
      });
    } else {
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          timeView = Duration(seconds: times).toString().split('.').first;
          if (times <= 0) {
            timeStop();
          }
          times--;
        });
      });
    }
  }

  void timeStop() {
    timer.cancel();
  }

  void timeReset() {
    setState(() {
      timeStop();
      // times = totalTime;
      times = 60;
      isRunning = false;
      timeView = Duration(seconds: times).toString().split(".").first;
    });
  }

  void addTime(int sec) {
    times += sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeView = Duration(seconds: times).toString().split(".").first;
    });
  }

  @override
  Widget build(BuildContext context) {
    // times = totalTime;
    timeView = Duration(seconds: times).toString().split('.').first;
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(255, 3, 194, 12),
                child: const Center(
                  child: Text(
                    'My timer',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.cyan,
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tiemButton(sec: 30, color: Colors.white),
                    tiemButton(sec: 60, color: Colors.amber),
                    tiemButton(sec: -30, color: Colors.green),
                    tiemButton(sec: -60, color: Colors.pink),
                  ],
                ),
              )),
          Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    timeView,
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(255, 0, 255, 191),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        IconButton(
                          onPressed: timeStart,
                          icon: const Icon(Icons.pause_circle_rounded),
                          iconSize: 50,
                        )
                      else
                        IconButton(
                          onPressed: timeStart,
                          icon: const Icon(Icons.play_circle_rounded),
                          iconSize: 50,
                        ),
                      IconButton(
                        onPressed: timeReset,
                        icon: const Icon(Icons.restore_rounded),
                        iconSize: 50,
                      )
                    ],
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  GestureDetector tiemButton({required int sec, required Color color}) {
    return GestureDetector(
      onTap: () => addTime(sec),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: Text('$sec')),
      ),
    );
  }
}
