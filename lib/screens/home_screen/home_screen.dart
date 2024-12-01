
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/cubit.dart';
import 'package:tic_tac_toe/cubit/state.dart';
import 'package:tic_tac_toe/services/services.dart';
import '../board_screen/board_screen.dart';
class HomeScreen extends StatelessWidget {
  late bool isComputer;
  HomeScreen(this.isComputer,{super.key});
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
          leading:IconButton(onPressed: (){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back) ,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                   Text(
                    "TIC  TAK  TOE",
                    style:  Theme.of(context).textTheme.displayLarge
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  /// to enter first play name
                  textField(text:isComputer? "Computer":"Name of player X",
                    controller: xController,
                    validator: (String? note) {
                    //if is computer you don't need to enter first name
                      if(!isComputer)
                      {
                        if (note!.isEmpty) {
                          return "enter Name please";
                        }
                        return null;
                      } },
                    readOnly:isComputer? true:false,
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
                    }, readOnly: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /// start button
                  customeButton(
                    context: context,
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        if(isComputer)
                          xController.text="Computer";
                        cubit.setName(xController.text, oController.text,isComputer);
                        oController.clear();
                        xController.clear();
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return  BoardScreen(isComputer);
                        }));
                      }
                    },
                    text: "S T A R T",
                    //color: 0xFFA93226,
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
