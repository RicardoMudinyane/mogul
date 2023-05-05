import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/learningCards/cards.dart';
import 'package:provider/provider.dart';
import 'package:mogul/board.dart';
import 'package:mogul/handlers/providers.dart';

import '../constants.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  State<GamePlay> createState() => _HomeState();
}

class _HomeState extends State<GamePlay>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _translationAnimation;
  late Animation<double> perspectiveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..addListener(() {
      setState(() {});
    });

    _rotationAnimation = CurvedAnimation(
      parent: _controller,
      curve: const ElasticInOutCurve(0.7),
    ).drive(Tween<double>(
      begin: 0,
      end: -0.25,
    ));

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const ElasticInOutCurve(0.7),
    ).drive(Tween<double>(
      begin: 1,
      end: 1.75,
    ));

    _translationAnimation = CurvedAnimation(
      parent: _controller,
      curve: const ElasticInOutCurve(0.7),
    ).drive(Tween<Offset>(
      begin: Offset.zero,
      end:const Offset(0, -0.35),
    ));

    perspectiveAnimation =  Tween<double>(
      begin: 0,
      end: -.6,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleButtonPress() {
    _controller.forward();
    context.read<ProviderHandler>().rotateText(1);

    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).push(_createRoute());
    }).
    then((value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _controller.reverse();
        context.read<ProviderHandler>().rotateText(0);
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Consumer<ProviderHandler>(
              builder: (ctx, value, child){
                return Text(
                  value.name,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      fontSize: 12
                  ),
                );
              },
            ),
          )
        ),
        Positioned(
          right: -80,
          top: 70,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue.withOpacity(.05)
            ),
          ),
        ),

        Positioned(
          left: -50,
          bottom: 200,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(.05)
            ),
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SlideTransition(
                  position: _translationAnimation,
                  child: Board()
              ),
            ),
          ),
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Consumer<ProviderHandler>(
                      builder: (ctx, value, child){
                        return Column(
                          children: [
                            TextButton(
                              onPressed: handleButtonPress,
                              child:  Text(
                                'Start Learning',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12
                                ),
                              ),
                            ),
                            Container(
                              height: 3,
                              width: width*.12,
                              color: mainBlue,
                            )
                          ],
                        );
                      }
                  )
                )
            )
        )

      ],
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ECards(gameLevel: 1,),
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

