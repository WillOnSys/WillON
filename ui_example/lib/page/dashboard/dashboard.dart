/// DashBoard
/// @author Chen Miao
/// @data 2023/10/12

import 'package:flutter/material.dart';
import 'package:ui_example/page/dashboard/dashboard_first.dart';
import 'package:ui_example/page/dashboard/dashboard_second.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        FirstPage(),
        SecondPage(),
      ],
    );
  }
}