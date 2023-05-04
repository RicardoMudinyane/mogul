import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'board.dart';

class MonopolyBoard extends StatefulWidget {
  const MonopolyBoard({super.key});

  @override
  MonopolyBoardState createState() => MonopolyBoardState();
}

class MonopolyBoardState extends State<MonopolyBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _perspective = 0.01;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _perspective = lerpDouble(0.1, 0.01, _animation.value)!;
        });
      });

    _animationController.forward();
  }
  double scaleValue = 0;
  double _rotationY = 0;
  double _rotationZ = 3.15;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [

            // GestureDetector(
            //   onHorizontalDragUpdate: (details) {
            //     setState(() {
            //       _rotationY += details.delta.dx / 100;
            //     });
            //   },
            //   onVerticalDragUpdate: (details) {
            //     setState(() {
            //       _rotationZ += details.delta.dy / 100;
            //     });
            //
            //     print(_rotationZ);
            //   },
            //   child:
            // ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                  // ..setEntry(3, 2, _perspective)
                    ..rotateZ(_rotationZ)
                    ..rotateY(_rotationY)
                    ..scale(1),
                  alignment: Alignment.center,
                  child: const Board(),
                );
              },
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: (){
                    startGame();
                  },
                  child: const Text(
                      "Start"
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

  void startGame(){

    for (double i = _rotationZ; i > 1.5; i=i-0.2){
      setState(() {
        _rotationZ = i;
      });
    }
    setState(() {
      scaleValue = 1.5;
    });
  }
}


class RotatingContainer extends StatefulWidget {
  @override
  _RotatingContainerState createState() => _RotatingContainerState();
}

class _RotatingContainerState extends State<RotatingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _translateAnimation;

  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
      setState(() {});
    });

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 90.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _translateAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_isRotated) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              _isRotated = !_isRotated;
            });
          },
          child: Text('Rotate'),
        ),
        SizedBox(height: 50.0),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateZ(_rotateAnimation.value * (3.14 / 180))
            ..scale(_scaleAnimation.value, _scaleAnimation.value)
            ..translate(
              _translateAnimation.value.dx * MediaQuery.of(context).size.width,
              _translateAnimation.value.dy * MediaQuery.of(context).size.height,
            ),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
