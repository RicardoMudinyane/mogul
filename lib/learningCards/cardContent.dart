import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../objectClass.dart';

class CardContent extends StatelessWidget {
  final List<Color> cardGradient;
  final int index;
  final Level level;
  const CardContent({Key? key,
    required this.cardGradient,
    required this.level,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Hero(
        tag: "${level.levelNumber}${level.levelCards[index].cardName}",
        child: Material(
          type: MaterialType.transparency,
          child:  Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: cardGradient.map((e) =>
                        e.withOpacity(.4)).toList(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                )
            ),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                        onPressed: ()=> Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        )
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    level.levelCards[index].cardName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    level.levelCards[index].cardContent,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
