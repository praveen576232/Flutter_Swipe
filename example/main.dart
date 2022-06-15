import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swipe_me/swiper.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter  Swipe Page Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          // Swiping Button
           SwipingButton(
             validateOnScroll: ()=> true, // Validator If False You Cant Scroll
           text: "Swipe Me ", // Text
           turnOfAnimation:  false, // Turn Of The Text Animation
           size:const Size(400, 60),
           thumbWidth: 80,
            bgColor:     Colors.grey.shade200,
            textGradientColor: const[
              Colors.red,
              Colors.yellow
            ],
            boxShadow: [
                 BoxShadow(
             color: Colors.grey.shade200,
            offset: Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: 8),
        BoxShadow(
               color:Colors.grey.shade200,
            offset: Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 8)
            ],
            swipedBgColor: Colors.red,
           
           textStyle:const TextStyle().copyWith(
                   color: Colors.grey[400]!.withOpacity(.5),
                   
              ),
           swipingButtonController: (cont){
            //get the Controller
           },
           onSwipeComplete: (){
            print("Done");
           },
           )
          ],
        ),
      ),
    
    );
  }
}
