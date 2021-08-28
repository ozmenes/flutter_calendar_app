import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: const Color(0xff30384c),
      ),
      home: const CalendarPage(title: 'Flutter Calendar App'),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final String title;
  const CalendarPage({required this.title,Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  late CalendarController _controller;

  TextStyle dayStyle(FontWeight _fontWeight){
    return TextStyle(
      color: const Color(0xff30384c), fontWeight: _fontWeight
    );
  }
  Container taskList(String _title, String _desc,IconData _icon,Color _iconColor){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(
            _icon,
            color: _iconColor,
            size: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            width: MediaQuery.of(context).size.width *0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  _desc,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Container(
          //color: const Color(0xff30384c),
            child:  SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    locale: 'de_DE',
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                        weekdayStyle:  dayStyle(FontWeight.normal),
                        weekendStyle:  dayStyle(FontWeight.normal),
                        selectedColor: const Color(0xff30374b),
                        todayColor: const Color(0xff30374b)
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle:  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xff30384c)),
                      weekdayStyle:  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xff30384c)),
                      dowTextBuilder: (date, locale){
                        return DateFormat.E(locale).format(date).substring(0,2);
                      }
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Color(0xff30384c)),
                      leftChevronIcon: Icon(Icons.chevron_left,color: Color(0xff30384c),size: 30,),
                      rightChevronIcon: Icon(Icons.chevron_right,color: Color(0xff30384c),size: 30,),
                    ),
                    calendarController: _controller,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 30.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color:  Color(0xff30384c),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0)
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              const Padding(
                                padding:  EdgeInsets.only(top: 50.0),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              taskList('Task 1','Desc of Task 1 to be updated here.',CupertinoIcons.check_mark_circled,Colors.yellow),
                              taskList('Task 2','Desc of Task 2 to be updated here.',CupertinoIcons.check_mark_circled,Colors.yellow),
                              taskList('Task 3','Desc of Task 3 to be updated here.',CupertinoIcons.clock_solid,Colors.orange),
                              taskList('Task 4','Desc of Task 4 to be updated here.',CupertinoIcons.clock_solid,Colors.orange),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            height: 450,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        const Color(0xff30384c).withOpacity(0),
                                        const Color(0xff30384c)
                                      ],
                                    stops: const[
                                      0.0,
                                      1.0
                                    ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.white,
        child: const Icon(Icons.new_label,color: Color(0xff30384c),size: 28,),
      ),
    );
  }
}