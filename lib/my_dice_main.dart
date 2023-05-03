import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_portfolio/my_dice.dart';

void main() {
  runApp(const MyDice());
}

class MyDice extends StatefulWidget {
  const MyDice({super.key});

  @override
  State<MyDice> createState() => _MyDiceState();
}

class _MyDiceState extends State<MyDice> {
  Dice dice = Dice(size: 23);

  late Timer timer;
  dynamic resultNum = 0;
  String resultView = '';
  bool isStart = false;

  void start() {
    if (!isStart & dice.dice.isNotEmpty) {
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        dice.shake();
        setState(() {
          resultNum = dice.dice[0];
          isStart = true;
        });
      });
    }
  }

  void pickUp() {
    if (dice.dice.isNotEmpty && isStart) {
      setState(() {
        resultView = '$resultView ${dice.pick()}';
      });

      if (dice.dice.isEmpty) {
        timer.cancel();
        setState(() {
          isStart = false;
          resultNum = '끝!';
        });
      }
    }
  }

  void reset() {
    setState(() {
      resultNum = '';
      resultView = '';
      dice.init();
      if (isStart) {
        timer.cancel();
      }
      isStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Flexible(
                flex: 2,
                child: Center(
                  child: Text(
                    '$resultNum',
                    style: const TextStyle(color: Colors.black, fontSize: 60),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    resultView,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        iconSize: 100,
                        onPressed: start,
                        icon: const Icon(
                          Icons.play_circle,
                        )),
                    IconButton(
                        iconSize: 100,
                        onPressed: pickUp,
                        icon: const Icon(
                          Icons.check_circle_outline,
                        )),
                    IconButton(
                        iconSize: 100,
                        onPressed: reset,
                        icon: const Icon(
                          Icons.settings_backup_restore_outlined,
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
