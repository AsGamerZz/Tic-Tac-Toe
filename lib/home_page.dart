import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var winner = "";
  var grid = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  var currentPlayer = "X";
  void drawXO(i) {
    if (grid[i] == "") {
      setState(() {
        grid[i] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? '0' : 'X';
      });
      checkWinner(grid[i]);
    }
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    setState(() {
      winner = "";
      grid = [
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      ];
    });
  }

  void checkWinner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
        checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) || //rows
        checkMove(0, 3, 6, currentsign) ||
        checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign) || //colums
        checkMove(0, 4, 8, currentsign) ||
        checkMove(0, 4, 6, currentsign)) {
      setState(() {
        winner = currentsign;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("$winner WON"),
                content: const Text("Play Again"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        reset();
                        Navigator.pop(context);
                      },
                      child: const Text("Reset"))
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          children: [
            // if (winner != "")
            //   Text(
            //     "$winner Won",
            //     style:
            //         const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            //   ),
            Container(
              constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
              margin: const EdgeInsets.all(20),
              color: Colors.black,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: grid.length,
                itemBuilder: (context, index) => Material(
                  color: Colors.deepPurple,
                  child: InkWell(
                    onTap: () => drawXO(index),
                    splashColor: Colors.black,
                    child: Center(
                      child: Text(
                        grid[index],
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () => reset(),
                icon: const Icon(Icons.restore),
                label: const Text("Reset"))
          ],
        ),
      ),
    );
  }
}
