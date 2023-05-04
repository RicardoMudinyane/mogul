import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class Leader extends StatelessWidget {
  const Leader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double leader = width*.25;

    return Container(
      height: width*.28,
      width: leader,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: leader,
              height: leader,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: goldColor, width: 3),
                  image: const DecorationImage(
                      image: NetworkImage("https://hips.hearstapps.com/hmg-prod/images/janet-mock-attends-the-2020-vanity-fair-oscar-party-at-news-photo-1609863417.?crop=1xw:0.99991xh;center,top&resize=980:*"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width*.08,
              height: width*.08,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: goldColor
              ),
              child: Text(
                "1",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RunnerUp extends StatelessWidget {
  final String number;
  final String profile;
  final Color color;
  const RunnerUp({Key? key, required this.number, required this.profile, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double runnerUp = width*.2;
    double leader = width*.25;

    return Container(
      height: runnerUp+width*.03,
      width: runnerUp,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: runnerUp,
              height: runnerUp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2.5),
                  image: DecorationImage(
                      image: NetworkImage(profile),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width*.06,
              height: width*.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color
              ),
              child: Text(
                number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

