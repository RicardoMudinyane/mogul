import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/homePages/gamePage.dart';
import 'constants.dart';
import 'leaderboardWidget/topThree.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin {


  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut
      );
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    double runnerUp = width*.2;
    double leader = width*.25;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        alignment: Alignment.center,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: pageController,
          children:  [
            const GamePlay(),
            Container(
              width: width,
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  SizedBox(height: height*.06),
                  Text(
                    "Leaderboard",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: height*.02),

                  // TOP THREE
                  Container(
                    width: width,
                    height: width*.28,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        RunnerUp(
                          color: mainBlue,
                          number: "2",
                          profile: 'https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        ),
                        const Leader(),
                        RunnerUp(
                          color: purpleColor,
                          number: "3",
                          profile: "https://images.unsplash.com/photo-1638759281364-00a54a473ae3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: height*.02),
                  Container(
                    width: width*.95,
                    height: height*.06,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Rank",
                          style: GoogleFonts.poppins(
                              color: Colors.grey[900],
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "456",
                          style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.yellow,
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type:BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(
          size: 20,
          color: mainBlue
        ),
        unselectedIconTheme: IconThemeData(
            size: 20,
            color: Colors.grey[600]
        ),
        items: const  [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}

