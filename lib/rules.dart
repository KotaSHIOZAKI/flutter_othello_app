import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class CPage extends StatelessWidget {
  const CPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Center (
        child: Column (
          children: <Widget>[
            BorderedText(
              strokeWidth: 4.0, //縁の太さ
              strokeColor: Colors.black,
              child: const Text(
                "オセロのルール",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    "基本操作",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "赤枠にタップ：石を打つ"
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    "パス",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "打てる箇所がない場合パスになり、相手の手番になります。何回もパスをすると、そのまま進んでも負ける可能性があります。"
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    "着手",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "打てる箇所がある場合は必ず打たなければなりません。盤上のマスに故意に触れた場合、 そこが着手不可能でない限りそこに打たなくてはなりません。"
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    "勝敗",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "石の多い方が勝者となります。"
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text(
                "戻る",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
          ]
        ),
      )
    );
  }
}