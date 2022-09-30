import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

int column = 6;
int row = 6;
GameBoard gameBoard = GameBoard(6, 6);
var counts = [0, 0];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutterデモ ホームページ'),
        '/options': (context) => const Options(),
        '/game': (context) => const GameScreen(),
        '/c_page': (context) => const CPage(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BorderedText(
              strokeWidth: 4.0, //縁の太さ
              strokeColor: Colors.black,
              child: const Text(
                "オセロ",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/options');
              },
              child: const Text(
                "始める",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/c_page');
              },
              child: const Text(
                "ルール説明",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =================================== //

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

// =================================== //

class GameBoard {
  var array = List.generate(8, (_) => List.generate(8, (_) => BoardPiece(0)));

  GameBoard(int column, int row) {
    array = List.generate(column, (_) => List.generate(row, (_) => BoardPiece(0)));

    int colHalf = column ~/ 2;
    int rowHalf = row ~/ 2;
    //黒
    array[colHalf-1][rowHalf-1] = BoardPiece(2);
    array[colHalf][rowHalf] = BoardPiece(2);
    //白
    array[colHalf][rowHalf-1] = BoardPiece(1);
    array[colHalf-1][rowHalf] = BoardPiece(1);
  }
}
class BoardPiece {
  int situationId = 0; //0＝何もおかれていない状態、1＝黒い石、2＝白い石
  
  BoardPiece(this.situationId);

  bool get canPlace => (situationId == 0);

  set putStone(int stoneId) {
    situationId = stoneId;
  }
}
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
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );

      case 2:
      return Container( //石
        margin: const EdgeInsets.all(8.0),
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
        width: 40.0,
        height: 40.0,
        color: Colors.green,
        child: stoneDecorate(val, putStone(column, row, colorToggle, replace: false)),
      ),
    );
  }

  // Future<void> putStone(int column, int row, int color) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   var rowList = [];
  //   for (int i = row; i < gameBoard.array[column].length; i++) {
  //     rowList.add(i);
  //     if (gameBoard.array[column][i].situationId == color) {
  //       for (int val in rowList) {
  //         setState(() {
  //           gameBoard.array[column][val].putStone = color;
  //         });
  //       }
  //       break;
  //     }
  //   }
  // }
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

// =================================== //

class CPage extends StatelessWidget {
  const CPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("...")),
      body: Column (
        children: <Widget>[
          Text(
            "C Page",
            style: Theme.of(context).textTheme.headline1
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text("戻る"),
          ),
        ]
      )
    );
  }
}

class Template extends StatelessWidget {
  const Template({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Template")),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/sample');
            },
            child: const Text("次のページ"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text("ホームへ戻る"),
          ),
        ]
      ),
    );
  }
}