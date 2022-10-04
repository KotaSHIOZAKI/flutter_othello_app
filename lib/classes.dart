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