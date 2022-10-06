import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

int yourColor = 0;

class ColorSelect extends StatefulWidget {
  const ColorSelect({super.key});

  @override
  ColorsPage createState() => ColorsPage();
}
class ColorsPage extends State<ColorSelect> {
  var colorSelect = [true, false];

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
                "色の選択",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column (
                children: <Widget>[
                  const Text(
                    "あなたの色",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  ToggleButtons(
                    isSelected: colorSelect,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < colorSelect.length; i++) {
                          if (i == index) {
                            colorSelect[i] = true;
                            yourColor = i;
                          } else {
                            colorSelect[i] = false;
                          }
                        }
                      });
                    },
                    fillColor: Colors.green,
                    selectedColor: Colors.white,
                    children: const <Widget>[
                      Text("　黒　", style: TextStyle(fontSize: 20)),
                      Text("　白　", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
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