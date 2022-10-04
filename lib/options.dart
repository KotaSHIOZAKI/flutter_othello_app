import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Center(
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ToggleButtons(
              isSelected: sizeSelect,
              children: const <Widget>[
                Text("６×６"),
                Text("８×８"),
                Text("１０×１０"),
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
            ElevatedButton(
              onPressed: (){
                column = (_boardSize * 2) + 6;
                row = (_boardSize * 2) + 6;
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