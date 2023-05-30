import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    title: "Tic Tac Toe",
    debugShowCheckedModeBanner: false,
    home: TicTacToeGame(),
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
  ));
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  var circle = Icon(
    Icons.circle_outlined,
    size: 80,
    color: Colors.green,
  );
  var cross = Icon(
    Icons.cancel_rounded,
    size: 80,
    color: Colors.red,
  );
  var edit = Icon(
    Icons.rectangle_outlined,
    size: 82,
  );
  late List<String> gamestate;
  bool isPlayer1Turn = true;
  bool isGameOver = false;
  String message = '';

  @override
  void initState() {
    gamestate = List.filled(9, "empty");
    super.initState();
  }

  void playGame(int index) {
    if (!isGameOver && gamestate[index] == "empty") {
      setState(() {
        if (isPlayer1Turn) {
          gamestate[index] = "Cross";
        } else {
          gamestate[index] = "Circle";
        }
        isPlayer1Turn = !isPlayer1Turn;
        checkWin();
      });
    }
  }

  void checkWin() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (gamestate[combination[0]] != "empty" &&
          gamestate[combination[0]] == gamestate[combination[1]] &&
          gamestate[combination[1]] == gamestate[combination[2]]) {
        setState(() {
          message = '${gamestate[combination[0]]} Wins!';
          isGameOver = true;
        });
        break;
      } else if (!gamestate.contains("empty")) {
        setState(() {
          message = 'Game Draw';
          isGameOver = true;
        });
      }
    }
  }

  void resetGame() {
    setState(() {
      gamestate = List.filled(9, "empty");
      isPlayer1Turn = true;
      isGameOver = false;
      message = '';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 1.0,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.blue,
            padding: EdgeInsets.all(10),
            child: Text(
              isGameOver
                  ? message
                  : "Player ${isPlayer1Turn ? '1' : '2'}'s Turn",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: gamestate.length,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  playGame(i);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: getIcon(gamestate[i]),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: resetGame,
            child: Text(
              "Reset Game",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getIcon(String title) {
    switch (title) {
      case 'empty':
        return edit;
      case 'Circle':
        return circle;
      case 'Cross':
        return cross;
      default:
        return SizedBox.shrink();
    }
  }
}
