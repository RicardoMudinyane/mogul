import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _handleButtonPress() {
    _controller.forward();
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          right: -80,
          top: 0,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue.withOpacity(.1)
            ),
          ),
        ),

        // Transform(
        //     transform: Matrix4.identity()
        //       ..setEntry(3, 2, 0.002)
        //       ..rotateY(perspectiveAnimation.value),
        //     alignment: FractionalOffset.center,
        //     child: const Board()
        // ),

        Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SlideTransition(
                  position: _translationAnimation,
                  child: const Board()
              ),
            ),
          ),
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _handleButtonPress,
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
                  ),
                )
            )
        )

      ],
    );
  }
}

