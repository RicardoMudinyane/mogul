import 'package:flutter/material.dart';
import 'package:mogul/constants.dart';
import 'boardTiles.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double boxSize = (width*.8/4);

    return Container(
      width: width*.8,
      height: width*.8,
      color: Colors.transparent,
      child: Stack(
        children: [

          // Bottom Row
          Positioned(
            left: 0,
            bottom: 0,
            child: Row(
                children: [
                  BoardTile(color: mainBlue, name: "Start"),
                  BoardTile(color: orangeColor, name: "1"),
                  BoardTile(color: orangeColor, name: "2"),
                  BoardTile(color: orangeColor, name: "3"),
                ]
            ),
          ),

          // // Right Column
          Positioned(
            right: 0,
            bottom: boxSize,
            child: Column(
                children: [
                  BoardTile(color: orangeColor, name: "6"),
                  BoardTile(color: orangeColor, name: "5"),
                  BoardTile(color: orangeColor, name: "4"),
                ]
            ),
          ),

          // Top Row
          Positioned(
            right: boxSize,
            top: 0,
            child: Row(
                children: [
                  BoardTile(color: orangeColor, name: "9"),
                  BoardTile(color: orangeColor, name: "8"),
                  BoardTile(color: orangeColor, name: "7"),
                ]
            ),
          ),

          // Left Column
          Positioned(
            left: 0,
            top: boxSize,
            child: Column(
                children: [
                  BoardTile(color: orangeColor, name: "10"),
                  BoardTile(color: Colors.green, name: "Victory"),
                ]
            ),
          ),
        ],
      ),
    );
  }


}
