import 'package:flutter/material.dart';

class Level {
  int levelNumber;
  int levelPoints;
  bool isLevelDone;
  List<LevelCards> levelCards;
  LevelChallenge levelChallenge;

  Level({
    required this.levelNumber,
    required this.levelPoints,
    required this.isLevelDone,
    required this.levelCards,
    required this.levelChallenge,
  });
}
class LevelCards {
  String cardName;
  String cardContent;
  bool isCardRead;

  LevelCards({
    required this.cardName,
    required this.cardContent,
    required this.isCardRead,
  });
}
class LevelChallenge {
  String challengeName;

  LevelChallenge({
    required this.challengeName,
  });
}



class Circle {
  double x, y, r;
  String text;
  bool isClicked;
  Circle(this.x, this.y, this.r, this.text, this.isClicked);
}