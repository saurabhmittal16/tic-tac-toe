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
  int result = 0;
  
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
      game.fillRange(0, 9, '');
      isFirst = true;
      gameOver = false;
      moves = 0;
      result = 0;
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
          result = 1;
        } else if (game[i] == 'X') {
          result = 2;
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
          result = 1;
        } else if (game[i] == 'X') {
          result = 2;
        }
      }
    }

    // Check primary diagonal
    if (game[0] == game[4] && game[4] == game[8] && game[0] != '') {
      setState(() {
        gameOver = true;
      });
      if (game[0] == 'O') {
        result = 1;
      } else if (game[0] == 'X') {
        result = 2;
      }
    }
    
    // Check secondary diagonal
    else if (game[2] == game[4] && game[4] == game[6] && game[2] != '') {
      setState(() {
        gameOver = true;
      });
      if (game[0] == 'O') {
        result = 1;
      } else if (game[0] == 'X') {
        result = 2;
      }
    }

    if (moves == 9) {
      result = 0;
      setState(() {
        gameOver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.count(
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
          )
        ),
        Opacity(
          opacity: gameOver ? 1.0 : 0.0, 
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 36.0,
            ),
            child: Text(showResult(result), style: TextStyle(fontSize: 26))
          )
        ),
        Opacity(
          opacity: gameOver ? 1.0 : 0.0,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 32.0,
            ),
            child: GestureDetector(
              onTap: () {
                reset();
              },
              child: Text('Play Again? Click here', style: TextStyle(fontSize: 20)),
            )
          )
        ),
      ],
    );
  }
}