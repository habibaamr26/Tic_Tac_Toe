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
  List displayIndex = ["", "", "", "", "", "", "", "", ""];
  int fillBox = 0;
  int oScore = 0;
  int xScore = 0;

  void setName(xController, oController) {
    xName = xController;
    oName = oController;
    clearBoardNewGame();
    chooseRandomRange();
    emit(SetNameState());
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

  void indexOnTap(index, context) {
    if (displayIndex[index] == '') {
      fillBox++;
      onTap(index, context);
    }
    emit(OnTapState());
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
    checkWinner(context);
  }

  void checkWinner(context) {
    // Checking rows
    if (displayIndex[0] == displayIndex[1] &&
        displayIndex[0] == displayIndex[2] &&
        displayIndex[0] != '') {
      showToast(message: displayIndex[0], context: context);
    }

    else if (displayIndex[3] == displayIndex[4] &&
        displayIndex[3] == displayIndex[5] &&
        displayIndex[3] != '') {
      showToast(message: displayIndex[3], context: context);
    }

    else if (displayIndex[6] == displayIndex[7] &&
        displayIndex[6] == displayIndex[8] &&
        displayIndex[6] != '') {
      showToast(message: displayIndex[6], context: context);
    }

    // Checking Column
    else if (displayIndex[0] == displayIndex[3] &&
        displayIndex[0] == displayIndex[6] &&
        displayIndex[0] != '') {
      showToast(message: displayIndex[0], context: context);
    }
    else if (displayIndex[1] == displayIndex[4] &&
        displayIndex[1] == displayIndex[7] &&
        displayIndex[1] != '') {
      showToast(message: displayIndex[1], context: context);
    }
    else if (displayIndex[2] == displayIndex[5] &&
        displayIndex[2] == displayIndex[8] &&
        displayIndex[2] != '') {
      showToast(message: displayIndex[2], context: context);

    }


    // Checking Diagonal
    else if (displayIndex[2] == displayIndex[4] &&
        displayIndex[2] == displayIndex[6] &&
        displayIndex[2] != '') {
      showToast(message: displayIndex[2], context: context);

    }


    else if (displayIndex[0] == displayIndex[4] &&
        displayIndex[0] == displayIndex[8] &&
        displayIndex[0] != '') {
      showToast(message: displayIndex[0], context: context);

    }

    else if (fillBox == 9) {
      showToast(message: " Sorrry NO one", context: context);

    }
  }

  void showToast({
    required String message,
    required context,
  }) {
    if (message == 'x') {
      xScore++;
      message=xName!;
    } else if (message == 'o') {
      oScore++;
      message=oName!;
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
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Color(0xFFA93226 ),),
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: "Cancel"),
              ],
            ),
          );
        });
  }

  void clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayIndex[i] = '';
      fillBox = 0;
    }
    emit(ClearBoardState());
  }

  void clearBoardNewGame() {
    for (int i = 0; i < 9; i++) {
      displayIndex[i] = '';
      fillBox = 0;
      oScore = 0;
      xScore = 0;
    }
    emit(ClearBoardState());
  }
}
