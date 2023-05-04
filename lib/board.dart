import 'package:flutter/material.dart';
import 'boardTiles.dart';
import 'dart:ui' as ui;

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);



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
                  const BoardTile(color: Colors.red, name: "Start"),
                  BoardTile(color: Colors.pink[200]!, name: "1"),
                  BoardTile(color: Colors.pink[200]!, name: "2"),
                  BoardTile(color: Colors.pink[200]!, name: "3"),
                ]
            ),
          ),

          // // Right Column
          Positioned(
            right: 0,
            bottom: boxSize,
            child: Column(
                children: [
                  BoardTile(color: Colors.pink[200]!, name: "6"),
                  BoardTile(color: Colors.pink[200]!, name: "5"),
                  BoardTile(color: Colors.pink[200]!, name: "4"),
                ]
            ),
          ),

          // Top Row
          Positioned(
            right: boxSize,
            top: 0,
            child: Row(
                children: [
                  BoardTile(color: Colors.pink[200]!, name: "9"),
                  BoardTile(color: Colors.pink[200]!, name: "8"),
                  BoardTile(color: Colors.pink[200]!, name: "7"),
                ]
            ),
          ),

          // Left Column
          Positioned(
            left: 0,
            top: boxSize,
            child: Column(
                children: [
                  BoardTile(color: Colors.pink[200]!, name: "10"),
                  BoardTile(color: Colors.pink[200]!, name: "Goal"),
                ]
            ),
          ),


        ],
      ),
    );
  }
}
