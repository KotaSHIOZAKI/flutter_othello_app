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
            const Text(
              "あなたの色",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            ToggleButtons(
              isSelected: colorSelect,
              children: const <Widget>[
                Text("黒", style: TextStyle(fontSize: 20)),
                Text("白", style: TextStyle(fontSize: 20)),
              ],
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