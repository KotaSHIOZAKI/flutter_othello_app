import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import 'main.dart';
import 'main.dart' as main;
import 'computer.dart';
import 'classes.dart';

import 'color_select.dart';

var counts = [0, 0];
var blackPlacableCounts = 4;
var whitePlacableCounts = 4;
var judgeNum = 0;
int colorToggle = 1;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenPage createState() => GameScreenPage();
}
class GameScreenPage extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    if (colorToggle != yourColor + 1) {
      //COMが黒の場合
      cpDecide();

      setState(() {
        placableCount();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: LayoutBuilder(
        builder: (context, constraints) {
        return constraints.maxWidth < constraints.maxHeight
          ? vertical()
          : horizontal();
        },
      )
    );
  }

  Widget vertical() {
    return Column (
      children: <Widget>[
        //現在置かれている石の数
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
                  Text(
                    yourColor == 0 ? "あなた" : "COM",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24), 
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
                  Text(
                    yourColor == 0 ? "COM" : "あなた",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24), 
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
        //盤
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
        //勝敗判定
        judge(judgeNum),
        const Spacer(),
        //「やめる」ボタン
        endButton(judgeNum),
      ]
    );
  }
  Widget horizontal() {
    return Row (
      children: <Widget>[
        Column(
          children: <Widget>[
            //現在置かれている石の数
            Container(
              padding: const EdgeInsets.only(top: 15.0, bottom: 6.0),
              width: 150,
              height: 90,
              child: Container(
                color: Colors.green,
                margin: const EdgeInsets.all(6.0),
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(.3), 
                    1: FractionColumnWidth(.1), 
                    2: FractionColumnWidth(.2)
                  },
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      Text(
                        yourColor == 0 ? "あなた" : "COM",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18), 
                      ),
                      const Icon(
                        Icons.circle,
                        size: 24,
                      ),
                      Text(
                        "×${counts[0]}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18), 
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Text(
                        yourColor == 0 ? "COM" : "あなた",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18), 
                      ),
                      const Icon(
                        Icons.circle,
                        size: 24,
                        color: Colors.white,
                      ),
                      Text(
                        "×${counts[1]}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18), 
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: judge(judgeNum, sideways: true)
            ),
          ],
        ),
        //盤
        SizedBox(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height,
          child: Table(
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
        ),
        //「やめる」ボタン
        endButton(judgeNum),
      ]
    );
  }

  Container stoneDecorate(int val, bool placable) {
    BoxDecoration redOutline(bool placable) {
      if (placable) {
        //打つことが可能な場合
        return BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.red, width: 4),
        );
      } else {
        //不可能な場合
        return const BoxDecoration();
      }
    }
    switch (val) {
      case 1:
      return Container( //黒い石
        margin: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );

      case 2:
      return Container( //白い石
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
  GestureDetector board(int column, int row, int val) {
    BoardPiece piece = gameBoard.array[column][row];

    double minSize = MediaQuery.of(context).size.width;
    if (minSize > MediaQuery.of(context).size.height) {
      minSize = MediaQuery.of(context).size.height;
    }
    debugPrint("${minSize / main.column}");

    return GestureDetector(
      onTap: () {
        if (piece.canPlace && colorToggle == yourColor + 1) {
          int color = colorToggle;
          bool put = putStone(column, row, color) > 0;
          if (put) {
            setState(() {
              //打つ
              piece.putStone = color;
              stoneCounts();

              //交代
              if (colorToggle == 1) {
                colorToggle = 2;
              } else {
                colorToggle = 1;
              }
              cpDecide();

              placableCount();
            });
          }
        }
      },
      child: Container(
        width: minSize / main.column,
        height: minSize / main.row,
        color: Colors.green,
        child: stoneDecorate(val, putStone(column, row, colorToggle, replace: false) > 0),
      ),
    );
  }

  Widget judge(int num, {bool sideways = false}) {
    double sizeRate = sideways ? 0.75 : 1.00;
    String newLine = sideways ? "\n" : "";

    switch (num) {
      case 0:
      //あなたの番
      return BorderedText(
        strokeWidth: 3.0,
        strokeColor: Colors.black,
        child: Text(
          "あなたの番です。\n赤枠の場所に$newLineタップしてください。",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 20 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      case 1:
      //打てない場合
      return ElevatedButton(
        onPressed: (){
          setState(() {
            if (colorToggle == 1) {
              colorToggle = 2;
            } else {
              colorToggle = 1;
            }
            cpDecide();

            placableCount();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, //ボタンの背景色
        ),
        child: Text(
          "パス",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25 * sizeRate,
            color: Colors.white,
          ), 
        ),
      );

      case 2:
      //COMの番
      return BorderedText(
        strokeWidth: 3.0, //縁の太さ
        strokeColor: Colors.black,
        child: Text(
          "COMの番です。",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 20 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      case 3:
      //COMが打てない場合
      return BorderedText(
        strokeWidth: 3.0, //縁の太さ
        strokeColor: Colors.black,
        child: Text(
          "COMはパスをした！",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 20 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      case 4:
      //勝利
      return BorderedText(
        strokeWidth: 3.0, //縁の太さ
        strokeColor: Colors.black,
        child: Text(
          "あなたの$newLine勝利！",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 40 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      case 5:
      //敗北
      return BorderedText(
        strokeWidth: 3.0, //縁の太さ
        strokeColor: Colors.black,
        child: Text(
          "COMの$newLine勝利！",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 40 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      case 6:
      //引き分け
      return BorderedText(
        strokeWidth: 3.0, //縁の太さ
        strokeColor: Colors.black,
        child: Text(
          "引き分け",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 40 * sizeRate,
            color: Colors.white,
          ),
        ),
      );

      default:
      return Container();
    }
  }
  Widget endButton(int num) {
    if (num >= 4) {
      return ElevatedButton(
        onPressed: (){
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.replay),
                    title: const Text("もう一度"),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        blackPlacableCounts = 4;
                        whitePlacableCounts = 4;
                        judgeNum = 0;

                        gameBoard = GameBoard(column, row);
                        stoneCounts();
                        colorToggle = 1;

                        if (yourColor == 1) {
                          cpDecide();
                          placableCount();
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("オプション"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                      Navigator.pushNamed(context, '/options');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.close),
                    title: const Text("終わる"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  ),
                ],
              );
            }
          );
        },
        child: const Text(
          "メニュー",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20), 
        ),
      );
    } else if (num <= 1) {
       return ElevatedButton(
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        child: const Text(
          "やめる",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20), 
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> cpDecide() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    ComputerManager manager = ComputerManager();

    setState(() {
      manager.comDecide();

      //交代
      if (colorToggle == 2) {
        colorToggle = 1;
      } else {
        colorToggle = 2;
      }
      
      placableCount();
    });
  }
}

void stoneCounts() {
  counts = [0, 0]; //0番目：黒、1番目：白

  for (var row in gameBoard.array) {
    for (var value in row) {
      if (value.situationId == 1) {
        //黒
        counts[0]++;
      } else if (value.situationId == 2) {
        //白
        counts[1]++;
      }
    }
  }
}
int putStone(int column, int row, int color, {bool replace = true}) {
  if (!replace && gameBoard.array[column][row].situationId != 0) {
    return 0;
  }

  int replaceStone(int col, int row, int columnAdd, int rowAdd, bool replace) {
    //石をひっくり返す
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
        //例：●○○○○●←return 1
        return 1;
      } else {
        int result = replaceStone(col, row, columnAdd, rowAdd, replace);
        if (result >= 1) {
          if (replace) {
            // Future.delayed(const Duration(milliseconds: 300));
            gameBoard.array[col][row].putStone = color;
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
      //石を挟んでひっくり返せた場合
      gameBoard.array[column][row].putStone = color;
      stoneCounts();
      placableCount();
    }
  }
  return total;
}

void placableCount() {
  blackPlacableCounts = 0;
  whitePlacableCounts = 0;

  for (int c = 0; c < gameBoard.array.length; c++) {
    for (int r = 0; r < gameBoard.array[c].length; r++) {
      blackPlacableCounts += putStone(c, r, 1, replace: false) > 0 ? 1 : 0;
      whitePlacableCounts += putStone(c, r, 2, replace: false) > 0 ? 1 : 0;
    }
  }

  if (blackPlacableCounts <= 0 && whitePlacableCounts <= 0) {
    if (counts[0] == counts[1]) {
      //引き分け
      judgeNum = 6;
    } else {
      //勝敗
      if (yourColor == 1) {
        judgeNum = counts[0] > counts[1] ? 5 : 4;
      } else {
        judgeNum = counts[0] > counts[1] ? 4 : 5;
      }
    }
  } else {
    //継続
    if (
      colorToggle == 1 && blackPlacableCounts <= 0 || 
      colorToggle == 2 && whitePlacableCounts <= 0 
    ) {
      if (colorToggle == yourColor + 1) {
        judgeNum = 1;
      } else {
        judgeNum = 3;
      }
    } else {
      judgeNum = (colorToggle == yourColor + 1) ? 0 : 2;
    }
  }
  stoneCounts();
}