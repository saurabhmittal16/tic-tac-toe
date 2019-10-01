import 'package:flutter/material.dart';
import 'move.dart';

String showResult(int playerNumber) {
  if (playerNumber == 0)
    return 'Tie';
  else if (playerNumber == 1)
    return 'You won!';
  else
    return 'You lost!';
}

bool isEndState(List<String> s) {
  var temp = findResult(s);
  if (temp == -1) return false;
  return true;
}

int findResult(List<String> game) {
  // Check rows
  for (int i = 0; i < 9; i += 3) {
    if (game[i] == game[i + 1] && game[i + 1] == game[i + 2] && game[i] != '') {
      if (game[i] == 'O') {
        return 1;
      } else if (game[i] == 'X') {
        return 2;
      }
    }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    if (game[i] == game[i + 3] && game[i + 3] == game[i + 6] && game[i] != '') {
      if (game[i] == 'O') {
        return 1;
      } else if (game[i] == 'X') {
        return 2;
      }
    }
  }

  // Check primary diagonal
  if (game[0] == game[4] && game[4] == game[8] && game[0] != '') {
    if (game[0] == 'O') {
      return 1;
    } else if (game[0] == 'X') {
      return 2;
    }
  }

  // Check secondary diagonal
  else if (game[2] == game[4] && game[4] == game[6] && game[2] != '') {
    if (game[2] == 'O') {
      return 1;
    } else if (game[2] == 'X') {
      return 2;
    }
  }

  // Check for empty spaces, if found -> game not over
  for (int i = 0; i < 9; i++) {
    if (game[i] == '') return -1;
  }

  // If no empty spaces and no winner then game is tied
  return 0;
}

int getScore(List<String> s, int depth) {
  int res = findResult(s);
  if (res == 1)
    return 10 + depth;
  else if (res == 2) return depth - 10;

  return 0;
}

// Minimax Algorithm
Move minimiser(List<String> s, int depth) {
  if (isEndState(s)) {
    return Move(score: getScore(s, depth), index: -1);
  }

  Move min = new Move(score: 1000, index: -1);

  for (int i = 0; i < 9; i++) {
    if (s[i] == '') {
      s[i] = 'X';

      Move curr = maximiser(s, depth + 1);
      if (curr.score < min.score) {
        min.score = curr.score;
        min.index = i;
      }
      s[i] = '';
    }
  }
  return min;
}

Move maximiser(List<String> s, int depth) {
  if (isEndState(s)) {
    return Move(score: getScore(s, depth), index: -1);
  }

  Move max = new Move(score: -1000, index: -1);

  for (int i = 0; i < 9; i++) {
    if (s[i] == '') {
      s[i] = 'O';

      Move curr = minimiser(s, depth + 1);
      if (curr.score > max.score) {
        max.score = curr.score;
        max.index = i;
      }
      s[i] = '';
    }
  }
  return max;
}

// UI Components
Widget getTile(int index, String text) {
  return Container(
      decoration: BoxDecoration(border: getBorders(index)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.w400),
        ),
      ));
}

Border getBorders(int index) {
  switch (index) {
    case 0:
      return Border(
          bottom: BorderSide(width: 2, color: Colors.purple),
          right: BorderSide(width: 2, color: Colors.purple));
    case 1:
      return Border(
          bottom: BorderSide(width: 2, color: Colors.purple),
          left: BorderSide(width: 2, color: Colors.purple),
          right: BorderSide(width: 2, color: Colors.purple));
    case 2:
      return Border(
        bottom: BorderSide(width: 2, color: Colors.purple),
        left: BorderSide(width: 2, color: Colors.purple),
      );
    case 3:
      return Border(
          top: BorderSide(width: 2, color: Colors.purple),
          bottom: BorderSide(width: 2, color: Colors.purple),
          right: BorderSide(width: 2, color: Colors.purple));
    case 4:
      return Border.all(width: 2, color: Colors.purple);
    case 5:
      return Border(
        top: BorderSide(width: 2, color: Colors.purple),
        bottom: BorderSide(width: 2, color: Colors.purple),
        left: BorderSide(width: 2, color: Colors.purple),
      );
    case 6:
      return Border(
          top: BorderSide(width: 2, color: Colors.purple),
          right: BorderSide(width: 2, color: Colors.purple));
    case 7:
      return Border(
          top: BorderSide(width: 2, color: Colors.purple),
          left: BorderSide(width: 2, color: Colors.purple),
          right: BorderSide(width: 2, color: Colors.purple));
    case 8:
      return Border(
        top: BorderSide(width: 2, color: Colors.purple),
        left: BorderSide(width: 2, color: Colors.purple),
      );
  }
  return Border.all(width: 2, color: Colors.purple);
}
