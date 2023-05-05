import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayTile extends StatelessWidget {
  final DateTime date;
  DayTile({Key? key, required this.date}) : super(key: key);

  final TextStyle mainSelected =  GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  final TextStyle mainUnselected =  GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  final TextStyle subSelected =  GoogleFonts.poppins(
    color: Colors.white70,
    fontSize: 10,
  );
  final TextStyle subUnselected =  GoogleFonts.poppins(
    color: Colors.grey[600],
    fontSize: 10,
  );

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: 60,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: DateFormat('dd/MM/yyyy').format(
            date
        ) == DateFormat('dd/MM/yyyy').format(date) ?
        Colors.lightBlue :
        DateFormat('dd/MM/yyyy').format(
            DateTime.now()
        ) == DateFormat('dd/MM/yyyy').format(date) ?
        Colors.lightBlue.withOpacity(.1) :
        Colors.grey[300]!.withOpacity(.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: DateFormat('dd/MM/yyyy').format(
                date
            ) == DateFormat('dd/MM/yyyy').format(date) ?
                mainSelected : mainUnselected
          ),
          const SizedBox(height: 1),
          Text(
            DateFormat.E().format(date),
              style: DateFormat('dd/MM/yyyy').format(
                  date
              ) == DateFormat('dd/MM/yyyy').format(date) ?
              subSelected : subUnselected
          ),
        ],
      ),
    );
  }
}