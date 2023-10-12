/// DashBoard
/// @author Chen Miao
/// @data 2023/10/12

import 'package:flutter/material.dart';

class OptionBar extends StatelessWidget {
  double _borderRadius;
  Color _borderColor;
  List<String> _items;

  OptionBar(this._borderRadius, this._borderColor, this._items);

  @override
  Widget build(BuildContext context) {    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: _borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            items: _items.map((value) => DropdownMenuItem(child: Text(value))).toList(),
            onChanged: (value) {
              
            },
          ),
        ),
      ),
    );
  }
}

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
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
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}