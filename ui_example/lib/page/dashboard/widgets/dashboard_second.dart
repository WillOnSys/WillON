import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_example/page/dashboard/widgets/util.dart';

class Calender extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calender> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _displayedMonth = DateTime.now();
  }

  void _selectDate(DateTime dateTime) {
    setState(() {
      _selectedDate = dateTime;
    });
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: _previousMonth,
            ),
            Text(
              DateFormat('MMMM yyyy').format(_displayedMonth),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: _nextMonth,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Sun'),
            Text('Mon'),
            Text('Tue'),
            Text('Wed'),
            Text('Thu'),
            Text('Fri'),
            Text('Sat'),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0).day,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemBuilder: (context, index) {
            DateTime date = DateTime(_displayedMonth.year, _displayedMonth.month, index + 1);
            bool isSelected = date == _selectedDate;
            bool isToday = date.year == DateTime.now().year && date.month == DateTime.now().month && date.day == DateTime.now().day;

            return GestureDetector(
              onTap: () => _selectDate(date),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.blue : (isToday ? Colors.blue : Colors.transparent),
                ),
                child: Center(
                  child: Text(
                    "${date.day}", 
                    style: TextStyle(
                      color: isSelected ? Colors.white : (isToday ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  final List<BlogCard> _userList = [
    BlogCard(
      Text("Maren Maureen"), 
      Text("user@email.com"), 
      ClipOval(
        child: Image.asset('assets/dashboard/profile.jpg', width: 50, height: 50, fit: BoxFit.cover,),
      ), 
      Icon(Icons.polyline_outlined), 
      Colors.orange
    ),
  ].expand((element) => List.generate(10, (_) => element)).toList();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      // TODO 这里有个问题，Expanded限制了Container的weight，使得weight无效化
      child: Container(
        width: 200.0,
        color: Colors.grey.shade200,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chen Miao"),
                      Text("chenmiao.ku@gmail.com")
                    ],
                  ),
                  ClipOval(
                    child: Image.asset('assets/dashboard/profile.jpg', width: 50, height: 50, fit: BoxFit.cover,),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Calender(),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Online User"),
                      SizedBox(width: 140,),
                      Text("See all"),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _userList.length,
                      itemBuilder: (context, index) {
                        return _userList[index];
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.blue,);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}