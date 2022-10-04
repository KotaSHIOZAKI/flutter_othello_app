import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'options.dart';
import 'game_screen.dart';
import 'rules.dart';
import 'classes.dart';

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
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