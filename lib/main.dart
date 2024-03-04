import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/cubit.dart';
import 'screens/begin_screen/begin screen.dart';

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
            backgroundColor:Color(0xFF6495ED),
          ),
          scaffoldBackgroundColor:Color(0xFF6495ED ),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),

          )
        ),
        home:  Start(),
      ),
    );
  }
}