import 'package:flutter/material.dart';
import 'utils.dart' as utils;
import 'move.dart';

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

// 1 Player Game
// User goes first and uses 'O'
// Game goes second and uses 'X'
// result = 0 -> Tie
// result = 1 -> Player won
// result = 2 -> Game won

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> game = new List.filled(9, '');
  bool gameOver = false;
  int moves = 0;
  int result = 0;
  
  void onClick(int index) {
    if (game[index] == '') {
      setState(() {
        game[index] = 'O';
        moves++;
      });
      checkVictory();
      gameMove();
    }
  }

  void reset() {
    setState(() {
      game.fillRange(0, 9, '');
      gameOver = false;
      moves = 0;
      result = 0;
    });
  }

  void checkVictory() {
    print(game);
    print(utils.isEndState(game));

    int res = utils.findResult(game);
    if (res != -1) {
      setState(() {
        result = res;
        gameOver = true;
      });
    }
  }

  gameMove() {
    if (!gameOver) {
      Move best = utils.minimiser(game, 0);
      print('Game sets -> ${best.index}');
      
      setState(() {
        game[best.index] = 'X';
        moves++;
      });

      checkVictory();
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
                  }
                },
                child: utils.getTile(index, game[index]),
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
            child: Text(utils.showResult(result), style: TextStyle(fontSize: 26))
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