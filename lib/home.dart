import 'package:flutter/material.dart';
import 'package:mogul/homePages/gamePage.dart';
import 'package:mogul/homePages/leaderBoard.dart';
import 'calendar/calendarEvent.dart';
import 'constants.dart';

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
      pageController.jumpToPage(
          index,
      );
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


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
              const LeaderBoard(),
              const CalendarReminder(),
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
            icon: Icon(Icons.calendar_month_rounded),
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

