import 'package:flutter/material.dart';
import 'utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Game()
      ),
    );
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> game = new List.filled(9, '');
  bool isFirst = true;
  bool gameOver = false;
  int moves = 0;
  
  onClick(int index) {
    if (game[index] == '') {
      setState(() {
        game[index] = isFirst ? 'O' : 'X';
        isFirst = !isFirst;
        moves++;
      });
    }
  }

  reset() {
    setState(() {
      game.fillRange(0, 8, '');
      isFirst = true;
      gameOver = false;
      moves = 0;
    });
  }

  checkVictory() {
    print(game);

    // Check rows
    for(int i=0; i<9; i+=3) {
      if (game[i] == game[i+1] && game[i+1] == game[i+2] && game[i] != '') {
        setState(() {
          gameOver = true;
        });
        if (game[i] == 'O') {
          print('Player 1 wins');
        } else if (game[i] == 'X') {
          print('Player 2 wins');
        }
      }
    }

    // Check columns
    for(int i=0; i<3; i++) {
      if (game[i] == game[i+3] && game[i+3] == game[i+6] && game[i] != '') {
        setState(() {
          gameOver = true;
        });
        if (game[i] == 'O') {
          print('Player 1 wins');
        } else if (game[i] == 'X') {
          print('Player 2 wins');
        }
      }
    }

    // Check primary diagonal
    if (game[0] == game[4] && game[4] == game[8] && game[0] != '') {
      setState(() {
        gameOver = true;
      });
      if (game[0] == 'O') {
        print('Player 1 wins');
      } else if (game[0] == 'X') {
        print('Player 2 wins');
      }
    }

    // Check secondary diagonal
    else if (game[2] == game[4] && game[4] == game[6] && game[2] != '') {
      setState(() {
        gameOver = true;
      });
      if (game[0] == 'O') {
        print('Player 1 wins');
      } else if (game[0] == 'X') {
        print('Player 2 wins');
      }
    }

    if (moves == 9) {
      print('Tie');
      setState(() {
        gameOver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return GestureDetector(
          onTap: () {
            if (!gameOver) {
              onClick(index);
              checkVictory();
            }
          },
          child: getTile(index, game[index]),
        );
      }),
    );
  }
}