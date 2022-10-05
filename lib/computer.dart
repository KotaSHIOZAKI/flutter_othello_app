import 'main.dart';
import 'game_screen.dart';
import 'options.dart';
import 'package:flutter/material.dart';

class ComputerManager {
  void comPut(int c, int r) {
    int color = 2;
    bool put = putStone(c, r, color) > 0;
    debugPrint("$put");
    if (put) {
      //打つ
      gameBoard.array[c][r].putStone = color;
      stoneCounts();
    }
  }

  void comDecide() {
    var maxArray = [0, 0];
    int maxCount = 0;

    var minArray = [0, 0];
    int minCount = 100;

    for (int c = 0; c < gameBoard.array.length; c++) {
      for (int r = 0; r < gameBoard.array[c].length; r++) {
        if (gameBoard.array[c][r].situationId == 0) {
          int count = putStone(c, r, 2, replace: false);
          if (count > maxCount) {
            maxCount = count;
            maxArray = [c, r];
          }
          if (count < minCount && count > 0) {
            minCount = count;
            minArray = [c, r];
          }
        }
      }
    }
    if (minCount == 100) {
      minCount = 0;
    }

    if (maxCount > 0 && comLevel == 2) {
      comPut(maxArray[0], maxArray[1]);
    } else if (minCount > 0 && comLevel == 0) {
      comPut(minArray[0], minArray[1]);
    }
    debugPrint("$maxCount");
  }
}