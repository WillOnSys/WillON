import 'package:flutter/material.dart';
import 'package:ui_example/page/dashboard/widgets/util.dart';

class FirstPage extends StatelessWidget {
  final List<BlogCard> _cardList = [
    BlogCard(
      Text('Blog1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
      Text('For Test Blog Card'), 
      Image.asset("assets/dashboard/book.jpg", width: 150,), 
      Icon(Icons.access_time_filled_rounded),
      Colors.blue
    ),
  ].expand((element) => List.generate(10, (_) => element)).toList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white60,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 30.0, 300.0, 40.0),
                  child: Text("My Blogs", style: TextStyle(
                    fontSize: 40
                  ),),
                ),
                Icon(Icons.search_rounded),
                SizedBox(width: 20.0,),
                Icon(Icons.notifications_active),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Text("Filter by:", style: TextStyle(fontSize: 20.0),),
                ),
                OptionBar(20.0, Colors.grey, ['Option1']),
                SizedBox(width: 20.0,),
                OptionBar(20.0, Colors.grey, ['Option1']),
                SizedBox(width: 20.0,),
                OptionBar(20.0, Colors.grey, ['Option1']),
                SizedBox(width: 20.0,),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _cardList.length,
                itemBuilder: (context, index) {
                  return _cardList[index];
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.blue,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}