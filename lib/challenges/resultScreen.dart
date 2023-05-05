import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/constants.dart';
import 'package:provider/provider.dart';
import '../handlers/providers.dart';
import '../learningCards/cards.dart';

class ChallengeResults extends StatelessWidget {
  ChallengeResults({Key? key}) : super(key: key);

  List<String> correctAnswer = [
    "Business plan",
    "Company Directors",
    "Business name",
    "Location",
    "Raising Capital"
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        body: Consumer<ProviderHandler>(
            builder: (ctx, value, child) {
              return Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .065),
                    Text(
                      "Your answers",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: value.levelResults.length,
                          separatorBuilder: (ctx, index) =>
                              SizedBox(height: height * .01),
                          itemBuilder: (ctx, index) {
                            return Container(
                              color: correctAnswer.contains(
                                  value.levelResults[index]) ?
                              Colors.green[300] : Colors.red[300],
                              child: ListTile(
                                title: Text(
                                  value.levelResults[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: correctAnswer.contains(
                                    value.levelResults[index]) ?
                                const Icon(
                                  Icons.done_rounded, color: Colors.white,
                                  size: 18,
                                ) :
                                const Icon(
                                  Icons.clear_rounded, color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          }
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                _createRoute());
                          },
                          child: Text(
                            "Next Level",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: mainBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                    )


                  ],
                ),
              );
            }
        )
    );
  }
}



Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ECards(gameLevel: 2),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}