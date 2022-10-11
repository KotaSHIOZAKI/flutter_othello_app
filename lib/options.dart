import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import 'main.dart';
import 'color_select.dart';
import 'game_screen.dart';
import 'classes.dart';

int comLevel = 1;

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  OptionsPage createState() => OptionsPage();
}
class OptionsPage extends State<Options> {
  int _boardSize = 1;
  var sizeSelect = [false, true, false];

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
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column (
                children: <Widget>[
                  const Text(
                    "サイズ",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  ToggleButtons(
                    isSelected: sizeSelect,
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
                    fillColor: Colors.green,
                    selectedColor: Colors.white,
                    children: const <Widget>[
                      Text(" 　６×６　 ", style: TextStyle(fontSize: 20)),
                      Text(" 　８×８　 ", style: TextStyle(fontSize: 20)),
                      Text(" １０×１０ ", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ]
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column (
                children: <Widget>[
                  const Text(
                    "COMの強さ",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  ToggleButtons(
                    isSelected: comSelect,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < comSelect.length; i++) {
                          if (i == index) {
                            comSelect[i] = true;
                            comLevel = i;
                          } else {
                            comSelect[i] = false;
                          }
                        }
                      });
                    },
                    fillColor: Colors.green,
                    selectedColor: Colors.white,
                    children: const <Widget>[
                      Text("　 弱い 　", style: TextStyle(fontSize: 20)),
                      Text("　 普通 　", style: TextStyle(fontSize: 20)),
                      Text("　 強い 　", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                blackPlacableCounts = 4;
                whitePlacableCounts = 4;
                column = (_boardSize * 2) + 6;
                row = (_boardSize * 2) + 6;
                judgeNum = 0;
                yourColor = 0;

                gameBoard = GameBoard(column, row);
                stoneCounts();
                colorToggle = 1;
                Navigator.pushNamed(context, '/color_select');
              },
              child: const Text(
                "決定",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text(
                "キャンセル",
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