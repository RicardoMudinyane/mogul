import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/challenges/levelOne.dart';
import 'package:mogul/constants.dart';
import 'package:mogul/learningCards/cardContent.dart';
import 'package:mogul/objectClass.dart';

class ECards extends StatefulWidget {
  final  int gameLevel ;
  ECards({Key? key, required this.gameLevel}) : super(key: key);

  @override
  State<ECards> createState() => _ECardsState();
}

class _ECardsState extends State<ECards> {
  late Level level;

  Level level1 = Level(
      levelNumber: 1,
      levelPoints: 15,
      isLevelDone: false,
      levelCards: [
        LevelCards(
            cardName: "Ideating",
            cardContent: "Choose a name that reflects your brand and "
                "is available for registration with the appropriate "
                "state agency",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Research and Planning",
            cardContent: "This is info about research",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Business Plan",
            cardContent: "Develop a business plan outlining the mission, "
                "goals, strategies, marketing plan, financial projections, "
                "and management structure of your business.",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Find your Directors",
            cardContent: "Choose the legal structure of your business, "
                "such as sole proprietorship, partnership, LLC, or corporation."
                " This will impact your tax liabilities, ownership structure, "
                "and legal requirements",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Fund your Business",
            cardContent: "This is info about research",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Business Location",
            cardContent: "Choose a location that is accessible, safe, and suits the needs of your business.",
            isCardRead: false
        ),
      ],
      levelChallenge: LevelChallenge(
          challengeName: "Re-Order"
      )
  );
  Level level2 = Level(
      levelNumber: 2,
      levelPoints: 30,
      isLevelDone: false,
      levelCards: [
        LevelCards(
            cardName: "Register your Business",
            cardContent: "Choose a name that reflects your brand and "
                "is available for registration with the appropriate "
                "state agency",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Apply for B-BBEE",
            cardContent: "This is info about research",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Licenses and Permits",
            cardContent: "Develop a business plan outlining the mission, "
                "goals, strategies, marketing plan, financial projections, "
                "and management structure of your business.",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Get Tax Number",
            cardContent: "Choose the legal structure of your business, "
                "such as sole proprietorship, partnership, LLC, or corporation."
                " This will impact your tax liabilities, ownership structure, "
                "and legal requirements",
            isCardRead: false
        ),
        LevelCards(
            cardName: "Open Organisation Acc",
            cardContent: "This is info about research",
            isCardRead: false
        ),
      ],
      levelChallenge: LevelChallenge(
          challengeName: "Re-Order"
      )
  );

  List<List<Color>> gradientColors = const [
    [Color(0xFFFF2CDF), Color(0xFF0014FF)],
    [Color(0xFF00E1FD), Color(0xFFFC007A)],
    [Color(0xFF00FF5B), Color(0xFF0014FF)],
    [Color(0xFF00FFFF), Color(0xFFFFE53B)],
    [Color(0xFF00E5FF), Color(0xFF1200FF)],
    [Color(0xFFFFE53B), Color(0xFFFF005B)],
    [Color(0xFFFF0A6C), Color(0xFF2D27FF)],
    [Color(0xFFFFE53B), Color(0xFFFF2525)],
  ];


  @override
  void initState() {
    // TODO: implement initState
    if(widget.gameLevel ==1 ){
      setState(() {
        level = level1;
      });
    }
    else{
      setState(() {
        level = level2;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: mainBlue.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: IconButton(
                      onPressed: ()=> Navigator.pop(context),
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                  ),
                ),
              ),
              SizedBox(height: height*.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Level ${level.levelNumber}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: const Color(0xFFf95b7b)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Total points for this level is ${level.levelPoints}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.grey[600]
                  ),
                ),
              ),


              SizedBox(height: height*.02),

              Expanded(
                flex: 30,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: level.levelCards.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (ctx, index)=> const SizedBox(height: 12),
                  itemBuilder: (ctx, index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardContent(
                              cardGradient: gradientColors[index],
                              level: level,
                              index: index
                          )),
                        );
                      },
                      child: Hero(
                          tag: "${level.levelNumber}${level.levelCards[index].cardName}",
                          child: Material(
                            color: Colors.transparent,
                            type: MaterialType.transparency,
                            child: Container(
                                width: width*.95,
                                height: height*.12,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: gradientColors[index].map((e) =>
                                            e.withOpacity(.4)).toList(),
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight
                                    )
                                ),
                                child: DefaultTextStyle(
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                  child: Text(
                                    level.levelCards[index].cardName,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                            ),
                          )
                      ),
                    );
                  }
              ),
              ),

              const Spacer(),

              // START CHALLENGE
              Container(
                width: width,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Ready for the Level Challenge ?",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.grey[600]
                  ),
                ),
              ),

              Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LevelOne()),
                      );
                    },
                    child: Container(
                      width: width*.5,
                      height: height*.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: mainBlue,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                        "Start",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(height: height*.02),
            ],
          ),
        ),
      )
    );
  }
}

