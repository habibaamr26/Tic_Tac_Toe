import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/services.dart';
import 'dart:math';

class TicTacBloc extends Cubit<TicTacState> {
  TicTacBloc() : super(InitState());

  static TicTacBloc get(context) => BlocProvider.of(context);

  String? xName;
  String? oName;
  bool? oTurn;
  List<String> displayIndex = ["", "", "", "", "", "", "", "", ""];
  int fillBox = 0;
  int oScore = 0;
  int xScore = 0;

// to work with local multiple player
  void indexOnTapMultiple(index, context) {
    if (displayIndex[index] == "") {
      fillBox++;
      onTap(index, context);
      emit(OnTapState());
    }
  }

  void onTap(
    index,
    context,
  ) {
    if (oTurn == true && displayIndex[index] == "") {
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
      displayIndex[i] = "";
    }
    fillBox = 0;
    oTurn = true;
    gameOver = false; // Reset the game-over flag
    emit(ClearBoardState());
  }

  void clearBoardNewGame() {
    for (int i = 0; i < 9; i++) {
      displayIndex[i] = "";
      fillBox = 0;
      oScore = 0;
      xScore = 0;
    }
    oTurn = true;
    gameOver = false;
    emit(ClearBoardState());
  }

  // required to show result
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
                      oTurnCumputer = true;
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
                      oTurnCumputer = true;
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

  String cumputerName = "Computer";

  bool oTurnCumputer = true;

  void setName(xController, oController, x) {
    if (x) {
      xName = cumputerName;
      oName = oController;
    } else {
      xName = xController;
      oName = oController;
      clearBoardNewGame();
      chooseRandomRange();
    }
    emit(SetNameState());
  }

  void onTapToComputer(index, context) {
    if (gameOver) return;
    if (displayIndex[index] == "" && oTurnCumputer == true) {
      displayIndex[index] = "o";
      fillBox++;
      oTurnCumputer = false;
      emit(OnTapState());
      checkWinShow(context);
      if (!gameOver) {
        Future.delayed(Duration(milliseconds: 500), findBestMove(displayIndex,context) as FutureOr Function()?);

      }
    } else if (displayIndex[index] == "" && oTurnCumputer == false) {
      displayIndex[index] = "x";
      fillBox++;
      oTurnCumputer = true;
      emit(OnTapState());
      checkWinShow(context);
    }
  }

  String checkWin() {
    // Checking rows
    if (displayIndex[0] == displayIndex[1] &&
        displayIndex[0] == displayIndex[2] &&
        displayIndex[0] != '') {
      return displayIndex[0]; // Winner is found
    } else if (displayIndex[3] == displayIndex[4] &&
        displayIndex[3] == displayIndex[5] &&
        displayIndex[3] != '') {
      return displayIndex[3]; // Winner is found
    } else if (displayIndex[6] == displayIndex[7] &&
        displayIndex[6] == displayIndex[8] &&
        displayIndex[6] != '') {
      return displayIndex[6]; // Winner is found
    }

    // Checking Columns
    else if (displayIndex[0] == displayIndex[3] &&
        displayIndex[0] == displayIndex[6] &&
        displayIndex[0] != '') {
      return displayIndex[0]; // Winner is found
    } else if (displayIndex[1] == displayIndex[4] &&
        displayIndex[1] == displayIndex[7] &&
        displayIndex[1] != '') {
      return displayIndex[1]; // Winner is found
    } else if (displayIndex[2] == displayIndex[5] &&
        displayIndex[2] == displayIndex[8] &&
        displayIndex[2] != '') {
      return displayIndex[2]; // Winner is found
    }

    // Checking Diagonal (Top-left to Bottom-right)
    else if (displayIndex[0] == displayIndex[4] &&
        displayIndex[0] == displayIndex[8] &&
        displayIndex[0] != '') {
      return displayIndex[0]; // Winner is found
    }

    // Checking Diagonal (Top-right to Bottom-left)
    else if (displayIndex[2] == displayIndex[4] &&
        displayIndex[2] == displayIndex[6] &&
        displayIndex[2] != '') {
      return displayIndex[2]; // Winner is found
    }

    // Checking for Draw
    else if (fillBox == 9) {
      return "draw"; // Draw condition if all cells are filled and no winner
    }

    return " "; // No winner yet
  }

  bool gameOver = false;

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

  Future findBestMove(board,context) async {
    int bestScore = -999;
    int bestindex = -1;
    //int bestCol = -1;
    //board[][] pieces = board.getPieces();

    for (int i = 0; i < 9; i++) {
      if (board[i] == "") {
        board[i] = "x";
        int moveValue = minimax(board, 0, false);
        board[i] = "";

        if (moveValue > bestScore) {
          bestindex = i;

          bestScore = moveValue;
        }
      }
    }
    if (bestindex != -1) {
      onTapToComputer(bestindex, context) ;
    }

  }


  // move wala result eka minimax algo eka use krla recuresive widihta check krnwa
  int minimax(pieces, int dep, bool isMaximizing) {
    var winner = checkWin();
    if (winner != null) {
      if (winner == "x") {
        return 10 - dep;
      } else if (winner == "o") {
        return dep - 10;
      }
    }
    if (gameOver) {
      return 0;
    }
    if (isMaximizing) {
      int bestScore = -999;
      for (int i = 0; i < 9; i++) {
        if (pieces[i] == "") {
          pieces[i] = "x";
          bestScore = max(bestScore, minimax(pieces, dep + 1, false));
          pieces[i] = "";
        }
      }
      return bestScore;
    } else {
      int bestScore = 9999;
      for (int i = 0; i < 9; i++) {
        if (pieces[i] == "") {
          pieces[i] = "o";
          bestScore = min(bestScore, minimax(pieces, dep + 1, true));
          pieces[i] = "";
        }
      }
      return bestScore;
    }
  }


}
