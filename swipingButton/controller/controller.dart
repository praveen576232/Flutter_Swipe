import 'package:flutter/material.dart';

class SwipeController extends ChangeNotifier{
   void reset(){
     notifyListeners();
   }
}