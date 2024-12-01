import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/services.dart';
import 'dart:math';

class TicTacBloc extends Cubit<TicTacState> {
  TicTacBloc() : super(InitState());
  static TicTacBloc get(context) => BlocProvider.of(context);
  // variable
  String? xName;
  String? oName;
  bool? oTurn;
  List<String> displayIndex = ["", "", "", "", "", "", "", "", ""];
  int fillBox = 0;
  int oScore = 0;
  int xScore = 0;
  String computerName = "Computer";
  bool oTurnComputer = true;
  bool gameOver = false;
  String emptySpace = "";

  /// to work with local multiplayer
  void indexOnTapMultiplayer(index, context) {
    if (displayIndex[index] == emptySpace) {
      fillBox++;
      onTap(index, context);
      emit(OnTapState());
    }
  }

  void onTap(
    index,
    context,
  ) {
    if (oTurn == true && displayIndex[index] == emptySpace) {
      displayIndex[index] = "o";
    } else {
      displayIndex[index] = "x";
    }
    if (oTurn == true) {
      oTurn = false;
    } else {
      oTurn = true;
    }
    checkWinShow(context);
  }

// to change every round how start
  void chooseRandomRange() {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    if (randomNumber % 2 == 0) {
      oTurn = false;
    } else {
      oTurn = true;
    }
  }

  void clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayIndex[i] = emptySpace;
    }
    fillBox = 0;
    oTurnComputer = true;
    gameOver = false; // Reset the game-over flag
    emit(ClearBoardState());
  }

  void clearBoardNewGame() {
    for (int i = 0; i < 9; i++) {
      displayIndex[i] = emptySpace;
      fillBox = 0;
      oScore = 0;
      xScore = 0;
    }
    oTurnComputer = true;
    gameOver = false;
    emit(ClearBoardState());
  }

  //to show result to user
  void showToast({
    required String message,
    required context,
  }) {
    if (message == 'x') {
      xScore++;
      message = xName!;
    } else if (message == 'o') {
      oScore++;
      message = oName!;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFD5D8DC),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage("assest/king_2701700.png"),
                  radius: 70,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "\" ${message} \" is Winner!!!",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Color(0xFFA93226),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customeButton(
                    context: context,
                    onPressed: () {
                      clearBoard();
                      Navigator.of(context).pop();
                    },
                    text: "Rematch"),
                const SizedBox(
                  height: 15,
                ),
                customeButton(
                    context: context,
                    onPressed: () {
                      clearBoardNewGame();
                      Navigator.of(context).pop();
                    },
                    text: "New Game"),
                const SizedBox(
                  height: 15,
                ),
                customeButton(
                    context: context,
                    color: 0xFFc0392b,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: "Cancel"),
              ],
            ),
          );
        });
  }

  void setName(xController, oController, isComputer) {
    if (isComputer) {
      xName = computerName;
      oName = oController;
      clearBoardNewGame();
      chooseRandomRange();
    } else {
      xName = xController;
      oName = oController;
      clearBoardNewGame();
      chooseRandomRange();
    }
    emit(SetNameState());
  }

  /// to work with computer
  void onTapToComputer(index, context) {
    if (gameOver) return;
    if (displayIndex[index] == emptySpace && oTurnComputer == true) {
      displayIndex[index] = "o";
      fillBox++;
      oTurnComputer = false;
      emit(OnTapState());
      checkWinShow(context);
      if (!gameOver) {
        Future.delayed(Duration(milliseconds: 500),
            findBestMove(displayIndex, context) as FutureOr Function()?);// AI makes its move after a short delay
      }
    } else if (displayIndex[index] == emptySpace && oTurnComputer == false) {
      displayIndex[index] = "x";
      fillBox++;
      oTurnComputer = true;
      emit(OnTapState());
      checkWinShow(context);
    }
  }

  String checkWin() {
    // Checking rows
    if (displayIndex[0] == displayIndex[1] &&
        displayIndex[0] == displayIndex[2] &&
        displayIndex[0] != emptySpace) {
      return displayIndex[0]; // Winner is found
    } else if (displayIndex[3] == displayIndex[4] &&
        displayIndex[3] == displayIndex[5] &&
        displayIndex[3] != emptySpace) {
      return displayIndex[3]; // Winner is found
    } else if (displayIndex[6] == displayIndex[7] &&
        displayIndex[6] == displayIndex[8] &&
        displayIndex[6] != emptySpace) {
      return displayIndex[6]; // Winner is found
    }
    // Checking Columns
    else if (displayIndex[0] == displayIndex[3] &&
        displayIndex[0] == displayIndex[6] &&
        displayIndex[0] != emptySpace) {
      return displayIndex[0]; // Winner is found
    } else if (displayIndex[1] == displayIndex[4] &&
        displayIndex[1] == displayIndex[7] &&
        displayIndex[1] != emptySpace) {
      return displayIndex[1]; // Winner is found
    } else if (displayIndex[2] == displayIndex[5] &&
        displayIndex[2] == displayIndex[8] &&
        displayIndex[2] != emptySpace) {
      return displayIndex[2]; // Winner is found
    }
    // Checking Diagonal (Top-left to Bottom-right)
    else if (displayIndex[0] == displayIndex[4] &&
        displayIndex[0] == displayIndex[8] &&
        displayIndex[0] != emptySpace) {
      return displayIndex[0]; // Winner is found
    }
    // Checking Diagonal (Top-right to Bottom-left)
    else if (displayIndex[2] == displayIndex[4] &&
        displayIndex[2] == displayIndex[6] &&
        displayIndex[2] != emptySpace) {
      return displayIndex[2]; // Winner is found
    } // Checking for Draw
    else if (fillBox == 9) {
      return "draw"; // Draw condition if all cells are filled and no winner
    }
    return " "; // No winner yet
  }
  ///check winner and call showToast to appear to user
  void checkWinShow(context) {
    // If the game is already over, do nothing
    if (gameOver) return;

    var result = checkWin();
    if (result == "x") {
      print("x is win");
      showToast(message: "x", context: context);
      gameOver = true; // Mark the game as over
    } else if (result == "o") {
      print("y is win");
      showToast(message: "o", context: context);
      gameOver = true; // Mark the game as over
    } else if (result == "draw") {
      print("draw is win");
      showToast(message: " Sorrry NO one", context: context);
      gameOver = true; // Mark the game as over
    }
  }

// Function to find the best move for the computer
  Future findBestMove(board, context) async {
    // Initialize best score and best move index
    int bestScore = -999;
    int bestIndex = -1;
    // Loop through all positions on the board to find the best move
    for (int i = 0; i < 9; i++) {
      if (board[i] == emptySpace){
        board[i] = "x";
        // Call minimax to evaluate the score of this move
        int moveValue = minimax(board, 0, false);
        board[i] = emptySpace;
        if (moveValue > bestScore) {
          bestIndex = i;
          bestScore = moveValue;
        }
      }
    }
    if (bestIndex != -1) {
      onTapToComputer(bestIndex, context);  // Make the move on the board
    }
  }

// Minimax function to calculate the score
  int minimax(pieces, int dep, bool isMaximizing) {
    // Check if there is a winner
    var winner = checkWin();
    if (winner != null) {
      if (winner == "x") {
        return 10 - dep; // Computer wins, return positive score
      } else if (winner == "o") {
        return dep - 10; // Player wins, return negative score
      }
    }
    if (gameOver) {
      return 0;
    }
    // Computer's turn, maximizing the score
    if (isMaximizing) {
      int bestScore = -999;
      for (int i = 0; i < 9; i++) {
        if (pieces[i] == emptySpace) {
          pieces[i] = "x";
          // Recursively call minimax to evaluate the move
          bestScore = max(bestScore, minimax(pieces, dep + 1, false));
          pieces[i] = emptySpace;  // Undo the move
        }
      }
      return bestScore;
    } else {
      //Player's turn, minimizing the score
      int bestScore = 9999;
      for (int i = 0; i < 9; i++) {
        if (pieces[i] == emptySpace) {
          pieces[i] = "o";
          // Recursively call minimax to evaluate the move
          bestScore = min(bestScore, minimax(pieces, dep + 1, true));
          pieces[i] = emptySpace;  // Undo the move
        }
      }
      return bestScore;  // Return the best score found for minimizing
    }
  }

}
