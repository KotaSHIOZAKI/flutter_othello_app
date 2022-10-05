import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import 'main.dart';
import 'game_screen.dart';
import 'classes.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  OptionsPage createState() => OptionsPage();
}
class OptionsPage extends State<Options> {
  int _boardSize = 1;
  var sizeSelect = [false, true, false];
  int _comLevel = 1;
  var comSelect = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Center(
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BorderedText(
              strokeWidth: 4.0, //縁の太さ
              strokeColor: Colors.black,
              child: const Text(
                "ゲーム形式",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              "サイズ",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            ToggleButtons(
              isSelected: sizeSelect,
              children: const <Widget>[
                Text("６×６", style: TextStyle(fontSize: 20)),
                Text("８×８", style: TextStyle(fontSize: 20)),
                Text("１０×１０", style: TextStyle(fontSize: 20)),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < sizeSelect.length; i++) {
                    if (i == index) {
                      sizeSelect[i] = true;
                      _boardSize = i;
                    } else {
                      sizeSelect[i] = false;
                    }
                  }
                });
              },
            ),
            const Text(
              "COMの強さ",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            ToggleButtons(
              isSelected: comSelect,
              children: const <Widget>[
                Text("弱い", style: TextStyle(fontSize: 20)),
                Text("普通", style: TextStyle(fontSize: 20)),
                Text("強い", style: TextStyle(fontSize: 20)),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < comSelect.length; i++) {
                    if (i == index) {
                      comSelect[i] = true;
                      _comLevel = i;
                    } else {
                      comSelect[i] = false;
                    }
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: (){
                blackPlacableCounts = 4;
                whitePlacableCounts = 4;
                column = (_boardSize * 2) + 6;
                row = (_boardSize * 2) + 6;
                judgeNum = 0;
                gameBoard = GameBoard(column, row);
                stoneCounts();
                Navigator.pushNamed(context, '/game');
              },
              child: const Text(
                "始める",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text(
                "やめる",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
          ]
        )
      ),
    );
  }
}