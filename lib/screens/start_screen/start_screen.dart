import 'package:flutter/material.dart';

import '../../services/services.dart';
import '../home_screen/home_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Image(
              image: AssetImage("assest/start.png"),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customeButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomeScreen(true);
                        }));
                      },
                      text: 'Play With Computer',
                      context: context),
                  SizedBox(
                    height: 20,
                  ),
                  customeButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomeScreen(false);
                        }));
                      },
                      text: 'Local MultiPlayer',
                      context: context),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
