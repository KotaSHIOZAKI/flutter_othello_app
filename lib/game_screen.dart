import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import 'main.dart';
import 'main.dart' as main;
import 'classes.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenPage createState() => GameScreenPage();
}
class GameScreenPage extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Column (
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Container(
              color: Colors.green,
              margin: const EdgeInsets.all(8.0),
              child: Table(
                columnWidths: const {
                  0: FractionColumnWidth(.3), 
                  1: FractionColumnWidth(.1), 
                  2: FractionColumnWidth(.2)
                },
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    const Text(
                      "あなた",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24), 
                    ),
                    const Icon(
                      Icons.circle,
                      size: 32,
                    ),
                    Text(
                      "×${counts[0]}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 24), 
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const Text(
                      "相手",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24), 
                    ),
                    const Icon(
                      Icons.circle,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "×${counts[1]}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 24), 
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              for (int i = 0; i < column; i++) ... {
                TableRow(children: <Widget>[
                  for (int j = 0; j < row; j++) ... {
                    board(i, j, gameBoard.array[i][j].situationId)
                  }
                ])
              }
            ],
          ),
          BorderedText(
            strokeWidth: 3.0, //縁の太さ
            strokeColor: Colors.black,
            child: const Text(
              "あなたの番です。\n赤枠の場所にタップしてください。",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, //ボタンの背景色
            ),
            child: const Text(
              "パス",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ), 
            ),
          ),
          const Spacer(),
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
    );
  }

  Container stoneDecorate(int val, bool placable) {
    BoxDecoration redOutline(bool placable) {
      if (placable) {
        return BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.red, width: 4),
        );
      } else {
        return const BoxDecoration();
      }
    }
    switch (val) {
      case 1:
      return Container( //石
        margin: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );

      case 2:
      return Container( //石
        margin: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );

      default:
      return Container(
        decoration: redOutline(placable),
      );
    }
  }
  int colorToggle = 1;
  GestureDetector board(int column, int row, int val) {
    BoardPiece piece = gameBoard.array[column][row];

    double minSize = MediaQuery.of(context).size.width;
    if (minSize > MediaQuery.of(context).size.height) {
      minSize = MediaQuery.of(context).size.height;
    }

    return GestureDetector(
      onTap: () {
        if (piece.canPlace) {
          int color = colorToggle;
          bool put = putStone(column, row, color);
          if (put) {
            setState(() {
              piece.putStone = color;
              stoneCounts();
            });

            if (colorToggle == 1) {
              colorToggle = 2;
            } else {
              colorToggle = 1;
            }
          }
        }
      },
      child: Container(
        width: minSize / main.column,
        height: minSize / main.row,
        color: Colors.green,
        child: stoneDecorate(val, putStone(column, row, colorToggle, replace: false)),
      ),
    );
  }

  bool putStone(int column, int row, int color, {bool replace = true}) {
    int replaceStone(int col, int row, int columnAdd, int rowAdd, bool replace) {
      col += columnAdd;
      row += rowAdd;
      if (
        col < 0 || row < 0 || 
        col >= gameBoard.array.length || row >= gameBoard.array[col].length
      ) {
        return 0;
      }

      if (gameBoard.array[col][row].situationId == 0) {
        return 0;
      } else {
        if (gameBoard.array[col][row].situationId == color) {
          return 1;
        } else {
          int result = replaceStone(col, row, columnAdd, rowAdd, replace);
          if (result >= 1) {
            if (replace) {
              setState(() {
                Future.delayed(const Duration(milliseconds: 300));
                gameBoard.array[col][row].putStone = color;
              });
            }
            return result + 1;
          }
          return result;
        }
      }
    }

    int total = 0;
    total += replaceStone(column, row, 0, 1, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, 0, -1, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, -1, 0, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, 1, 0, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, 1, 1, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, -1, -1, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, -1, 1, replace) > 1 ? 1 : 0;
    total += replaceStone(column, row, 1, -1, replace) > 1 ? 1 : 0;

    if (replace) {
      if (total > 0) {
        setState(() {
          gameBoard.array[column][row].putStone = color;
          stoneCounts();
        });
      } 
    }
    return total > 0;
  }
}

void stoneCounts() {
  counts = [0, 0];

  for (var row in gameBoard.array) {
    for (var value in row) {
      if (value.situationId == 1) {
        counts[0]++;
      } else if (value.situationId == 2) {
        counts[1]++;
      }
    }
  }
}