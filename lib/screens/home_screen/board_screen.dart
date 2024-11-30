import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/cubit.dart';
import 'package:tic_tac_toe/cubit/state.dart';

import '../../services/services.dart';

class BoardScreen extends StatelessWidget {
 late bool x;
   BoardScreen(this.x,{super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = TicTacBloc.get(context);
    return BlocConsumer<TicTacBloc, TicTacState>(
      builder: (BuildContext context, state) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customeIimageHomeBage(image: "assest/photo_2024-02-27_01-29-40.jpg",
                                  radius:x?cubit.oTurnCumputer==false ? 35 : 24:cubit.oTurn==false ? 35 : 25 ),

                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                cubit.xName!,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            margin: const EdgeInsets.all(20),
                            color: const Color(0xFFA93226),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${cubit.xScore}",
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                Container(
                                  width: 2.6,
                                  height: 20,
                                  margin: const EdgeInsets.all(20),
                                  color: Colors.white,
                                ),
                                Text(
                                  "${cubit.oScore}",
                                  style: Theme.of(context).textTheme.displayMedium,
                                )
                              ],
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customeIimageHomeBage(image: "assest/letter-o_6819204.png",
                                  radius:x?cubit.oTurnCumputer==true ? 35 : 24:cubit.oTurn==true ? 35 : 24 ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                cubit.oName!,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 380,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      //color: Colors.grey[300],
                    ),


                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 9,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if(x) {
                              cubit.onTapToComputer(index, context);
                            }
                            else{
                              cubit.indexOnTapMultiple(index, context);

                            }
                          },
                          child: Container(
                            width: 50,
                            height: 52,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Text(
                                  cubit.displayIndex[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                      );


                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  customeButton(
                    context: context,
                    onPressed: () {
                       Navigator.pop(context);
                       cubit.clearBoardNewGame();
                      },
                    text: "Leave",
                    //color: 0xFFA93226,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFA93226),
          onPressed: () {
            cubit.clearBoard();
          },
          child: const Icon(Icons.clear),
        ),
      ),
      listener: (BuildContext context, Object? state) {},
    );
  }
}
