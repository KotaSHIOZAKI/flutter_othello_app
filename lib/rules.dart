import 'package:flutter/material.dart';

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