import 'dart:math';

import 'main.dart';
import 'game_screen.dart';
import 'options.dart';
import 'package:flutter/material.dart';

class ComputerManager {
  void comPut(int c, int r) {
    int color = colorToggle;
    bool put = putStone(c, r, color) > 0;
    if (put) {
      //打つ
      gameBoard.array[c][r].putStone = color;
      stoneCounts();
    }
  }

  void comDecide() {
    List<List<int>> maxList = [];
    int maxCount = 0;

    List<List<int>> minList = [];
    int minCount = 100;

    for (int c = 0; c < gameBoard.array.length; c++) {
      for (int r = 0; r < gameBoard.array[c].length; r++) {
        if (gameBoard.array[c][r].situationId == 0) {
          int count = putStone(c, r, colorToggle, replace: false);
          //最大
          if (count > maxCount) {
            maxList = [[c, r]];
            maxCount = count;
          } else if (count == maxCount) {
            maxList.add([c, r]);
          }
          //最小
          if (count < minCount && count > 0) {
            minList = [[c, r]];
            minCount = count;
          } else if (count == minCount) {
            minList.add([c, r]);
          }
        }
      }
    }
    if (minCount == 100) {
      minCount = 0;
    }

    int rand = 0;
    if (maxCount > 0 && comLevel == 2) {
      rand = Random().nextInt(maxList.length);
      debugPrint("${maxList.length}");

      comPut(maxList[rand][0], maxList[rand][1]);
    } else if (minCount > 0 && comLevel == 0) {
      rand = Random().nextInt(minList.length);
      debugPrint("${minList.length}");
      
      comPut(minList[rand][0], minList[rand][1]);
    }
  }
}