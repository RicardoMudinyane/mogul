import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/leaderboardWidget/topThree.dart';

import '../constants.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var faker = Faker();

    return Container(
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
                  color: Colors.lightGreen[100]!.withOpacity(.5),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Rank",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    "48",
                    style: GoogleFonts.poppins(
                        color: Colors.lightGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              )
          ),
          SizedBox(height: height*.02),
          Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: width*.95,
                        height: height*.1,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: mainBlue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                          dense: true,
                          isThreeLine: true,
                          leading: const Icon(Icons.person_rounded),
                          title: Text(
                            faker.person.name(),
                            style: GoogleFonts.poppins(
                                color: Colors.grey[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          subtitle: Text(
                            "$index Points",
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          trailing: Text(
                            "${index+3}",
                            style: GoogleFonts.poppins(
                                color: Colors.lightGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, _)=> const SizedBox(height: 10.0),
                  itemCount: 50
              )
          ),
        ],
      ),
    );
  }
}
