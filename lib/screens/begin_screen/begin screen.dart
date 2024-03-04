import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/cubit.dart';
import 'package:tic_tac_toe/cubit/state.dart';
import 'package:tic_tac_toe/services/services.dart';
import '../home_screen/home screen.dart';
import 'begin_screen_componant.dart';

class Start extends StatelessWidget {

  TextEditingController oController = TextEditingController();
  TextEditingController xController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var  cubit=TicTacBloc.get(context);
    return BlocConsumer<TicTacBloc, TicTacState>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "TIC  TAC  TOE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),


        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  customeIimage(image: "assest/noughts-crosses_2162800.png", radius: 120),

                  const SizedBox(
                    height: 70,
                  ),

                  /// to enter first play name
                  textField(text: "Name of player X",
                    controller: xController,
                    validator: (String? note) {
                      if (note!.isEmpty) {
                        return "enter Name please";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  /// to enter second play name
                  textField(text: "Name of player O",
                    controller: oController,
                    validator: (String? note) {
                      if (note!.isEmpty) {
                        return "enter Name please";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// start button
                  customeButton(
                    context: context,
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        cubit.setName(xController.text, oController.text);
                        oController.clear();
                       xController.clear();
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return const HomeScreen();
                      }));
                      }
                    },
                    text: "S T A R T",
                    color: 0xFFA93226,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      listener: (BuildContext context, Object? state) {},
    );
  }
}










