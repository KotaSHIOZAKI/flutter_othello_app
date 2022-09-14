import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:bordered_text/bordered_text.dart';

void main() {
  runApp(const MyApp());
}

int column = 6;
int row = 6;
GameBoard gameBoard = GameBoard(6, 6);

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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/options');
              },
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset('images/imageA.png', fit: BoxFit.cover)
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/game');
                column = 8;
                row = 8;
                gameBoard = GameBoard(column, row);
              },
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset('images/imageB.png', fit: BoxFit.cover)
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/c_page');
              },
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset('images/imageC.png', fit: BoxFit.cover)
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
int _gValue = 1;
class OptionsPage extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 132, 0),
      body: Center(
        child: Column (
          children: <Widget>[
            RadioListTile(
              title: const Text('６×６'),
              value: 1,
              groupValue: _gValue,
              onChanged: (value){_onRadioSelected(value);},
            ),
            RadioListTile(
              title: const Text('８×８'),
              value: 2,
              groupValue: _gValue,
              onChanged: (value){_onRadioSelected(value);},
            ),
            RadioListTile(
              title: const Text('１０×１０'),
              value: 3,
              groupValue: _gValue,
              onChanged: (value){_onRadioSelected(value);},
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("戻る"),
            ),
          ]
        )
      ),
    );
  }
  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });
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
              child: const Text(
                "あなた ● × 99\nCOM ○ × 99",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 22,
                ),
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
              "あなたの番です。\nすきな場所にタップしてください。",
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
            child: const Text("やめる"),
          ),
        ]
      )
    );
  }

  Container stoneDecorate(int val) {
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
      return Container();
    }
  }
  int colorToggle = 1;
  GestureDetector board(int column, int row, int val) {
    BoardPiece piece = gameBoard.array[column][row];
    return GestureDetector(
      onTap: () {
        if (piece.canPlace) {
          int color = colorToggle;
          putStone(column, row, color);
          setState(() {
            piece.putStone = color;
          });

          if (colorToggle == 1) {
            colorToggle = 2;
          } else {
            colorToggle = 1;
          }
        }
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        color: Colors.green,
        child: stoneDecorate(val),
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
  void putStone(int column, int row, int color) {
    void replaceStone(int col, int row, int columnAdd, int rowAdd) {
      int j = col;
      bool same = false;
      var colList = [];
      var rowList = [];
      for (int i = row+rowAdd; i < gameBoard.array[column].length; i+=rowAdd) {
        try {
          j += columnAdd;
          if (j < 0 || j >= gameBoard.array.length || i < 0) {
            //範囲外の場合
            break;
          }

          colList.add(j);
          rowList.add(i);
          if (gameBoard.array[j][i].situationId == color && gameBoard.array[j][i].situationId > 0) {
            //相手の石を挟める場合
            same = true;
            break;
          }
          if (gameBoard.array[j][i].situationId == 0) {
            break;
          }
        } catch (e) {
          break;
        }
      }

      if (same) {
        for (int i = 0; i < colList.length; i++) {
          var replacedStone = gameBoard.array[colList[i]][rowList[i]];
          if (replacedStone.situationId > 0) {
            setState(() {
              replacedStone.putStone = color;
            });
          }
        }
      }
    }

    replaceStone(column, row, 0, 1);
    replaceStone(column, row, 0, -1);
    replaceStone(column, row, -1, 0);
    replaceStone(column, row, 1, 0);
    replaceStone(column, row, 1, 1);
    replaceStone(column, row, -1, -1);
    replaceStone(column, row, -1, 1);
    replaceStone(column, row, 1, -1);
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