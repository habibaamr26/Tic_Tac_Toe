



import 'package:flutter/material.dart';

import '../../services/services.dart';
import '../multiplayer/multiplayer_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children:[
             Image(image: AssetImage("assest/start.png"),fit: BoxFit.cover,),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customeButton( onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (_){return MultiPLayerScreen(true) ;})); }, text: 'Single Player', context: context),
                  SizedBox(height: 20,),
                  customeButton( onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_){return MultiPLayerScreen(false) ;}));
                  }, text: 'Local Multi Player', context: context),
                ],
              ),
            ),

          ]
        ),
      ),

    );
  }
}
