import 'package:flutter/material.dart';

class ProviderHandler extends ChangeNotifier {

  int textAngle = 0;
  String name = "Name";

  List<String> levelResults = [];

  changeName(String newName ){
    name = newName;
    notifyListeners();
  }
  rotateText(int turn){
    textAngle = turn;
    notifyListeners();
  }
  addLevelOneCircles(String text){
    levelResults.add(text);
    notifyListeners();
  }
  removeLevelOneCircles(String text){
    levelResults.removeWhere((element) => element == text);
    notifyListeners();
  }


}