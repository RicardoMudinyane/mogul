import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/challenges/resultScreen.dart';
import 'package:mogul/constants.dart';
import 'package:mogul/handlers/providers.dart';
import 'package:provider/provider.dart';

import '../objectClass.dart';

class LevelOne extends StatefulWidget {
  const LevelOne({Key? key}) : super(key: key);

  @override
  State<LevelOne> createState() => _LevelOneState();
}
class _LevelOneState extends State<LevelOne> {

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 300;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Challenge One",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.grey[900]
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: ()=> Navigator.pop(context),
                  child: Text(
                    "Quit",
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent.withOpacity(.8)
                    ),
                  ),
              )
            )
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: height*.01),
            Text(
              timerText,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFf95b7b)
              ),
            ),
            Text(
              "Remaining Time",
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]
              ),
            ),

            SizedBox(height: height*.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Select all steps you need to take before Registering your business",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900]
                ),
              ),
            ),

            SizedBox(height: height*.01),
            Container(
              width: width*.95,
              height: height*.65,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.1),
                borderRadius: BorderRadius.circular(15)
              ),
              child: NonOverlapCircles(height: height*.65, width: width*.9),
            ),


            SizedBox(height: height*.02),
            Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ChallengeResults()),
                    );
                  },
                  child: Consumer<ProviderHandler>(
                    builder: (ctx, value, child){
                      return Container(
                        width: width*.5,
                        height: height*.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFFf95b7b).withOpacity(.8),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                      );
                    }
                  )
                )
            ),

          ],
        ),
      ),
    );
  }

}



class NonOverlapCircles extends StatefulWidget{

  final double height;
  final double width;
  const NonOverlapCircles({super.key, required this.height, required this.width});

  @override
  NonOverlapCirclesState createState() => NonOverlapCirclesState();
}
class NonOverlapCirclesState extends State<NonOverlapCircles> {
  List<Circle> circles = [];
  final double radius = 50.0;
  final int maxTries = 100;

  final List<String> texts = [
    "Business plan",
    "Tax Return",
    "Company Directors",
    "Open Business Acc",
    "Business name",
    "Auditing",
    "Hire Team",
    "Licenses and permits",
    "Location",
    "Raising Capital"
  ];

  @override
  void initState() {
    super.initState();
    generateCircles();
  }

  bool isOverlapping(Circle newCircle) {
    for (Circle circle in circles) {
      double distance =
      sqrt(pow(circle.x - newCircle.x, 2) + pow(circle.y - newCircle.y, 2));
      if (distance < circle.r + newCircle.r) {
        return true;
      }
    }
    return false;
  }
  void generateCircles() {
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      int tryCount = 0;
      Circle newCircle;
      String text = texts[i];
      do {
        double x = random.nextDouble() * (widget.width - 2 * radius) + radius;
        double y = random.nextDouble() * (widget.height - 2 * radius) + radius;
        newCircle = Circle(x, y, radius, text, false);
        tryCount++;
      } while (isOverlapping(newCircle) && tryCount < maxTries);
      if (tryCount < maxTries) {
        circles.add(newCircle);
      }
    }
  }
  void _onTapCircle(int index) {
    setState(() {
      circles[index].isClicked = !circles[index].isClicked;

      if (circles[index].isClicked){
        context.read<ProviderHandler>().addLevelOneCircles(
            circles[index].text
        );
      }
      else{
        context.read<ProviderHandler>().removeLevelOneCircles(
            circles[index].text
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: circles.asMap().entries.map((entry) {
        int index = entry.key;
        Circle circle = entry.value;
        return Positioned(
          left: circle.x - circle.r,
          top: circle.y - circle.r,
          child: GestureDetector(
            onTap: () {
              _onTapCircle(index);
            },
            child: AnimatedContainer(
              width: circle.r * 2,
              height: circle.r * 2,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circle.isClicked ?
                mainBlue :
                Colors.lightBlueAccent.withOpacity(.8),
              ),
              child: Center(
                child: Text(
                  circle.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}