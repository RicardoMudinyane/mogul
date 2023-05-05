import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mogul/handlers/providers.dart';

class BoardTile extends StatelessWidget {
  final Color color;
  final String name;
  BoardTile({Key? key, required this.color, required this.name}) : super(key: key);

  // final pageKey = RipplePage.createGlobalKey();
  // final effectKey = RippleEffect.createGlobalKey();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: (width*.8)/4,
      height: (width*.8)/4,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
          child: Consumer<ProviderHandler>(
            builder: (ctx,value, child){
              return RotatedBox(
                quarterTurns: value.textAngle,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: ((width*.8)/4)/6,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
