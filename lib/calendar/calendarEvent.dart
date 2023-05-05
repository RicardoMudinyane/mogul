import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mogul/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import 'day_tile.dart';
import 'utils.dart';

class CalendarReminder extends StatefulWidget {
  const CalendarReminder({super.key});

  @override
  CalendarReminderState createState() => CalendarReminderState();
}

class CalendarReminderState extends State<CalendarReminder> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }


  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }
  DateTime _selectedDate = DateTime.now();


  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Container(
      height: height,
      width: width,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(10).copyWith(
        top: height*.05
      ),
      child:  Column(
        children: [
          const SizedBox(height: 10.0),
          TableCalendar(
            firstDay: kFirstDay,
            onDaySelected: (date, events) {
              setState(() {
                _selectedDate = date;
              });
            },
            onPageChanged: (date){
              setState(() {
                _selectedDate = date;
              });
            },
            headerVisible: false,
            daysOfWeekVisible : true,
            weekNumbersVisible: false,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.poppins(
                color: mainBlue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              weekendStyle: GoogleFonts.poppins(
                color: mainBlue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              // outsideBuilder: (context, date, events) {
              //   return DayTile(date: date);
              // },
              todayBuilder: (context, date, events) {
                return DayTile(date: date);
              },
              // defaultBuilder: (context, date, events) {
              //   return DayTile(date: date);
              // },
              selectedBuilder: (context, date, events) {
                return  DayTile(date: date);
              },
            ),
            selectedDayPredicate: (date) {
              return isSameDay(date, _selectedDate);
            },
            lastDay: kLastDay,
            focusedDay: _focusedDay.value,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onCalendarCreated: (controller) => _pageController = controller,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() => _calendarFormat = format);
              }
            },
          ),

        ],
      ),
    );
  }
}
