import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/cubit.dart';
import 'package:tic_tac_toe/screens/start_screen/start_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

      create: (BuildContext context)  =>TicTacBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:   AppBarTheme(
            elevation: 0,
            backgroundColor:Color(0xFF5b2c6f ),
          ),
          scaffoldBackgroundColor:Color(0xFF5b2c6f),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),
            displayLarge:TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),

          )
        ),
        home:  StartScreen(),
      ),
    );
  }
}