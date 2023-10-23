import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ui_example/page/login/widgets/login_left.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Container(
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('Will ON'),
                    MinimizeWindowButton(),
                    MaximizeWindowButton(),
                    CloseWindowButton(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // colors: [Colors.white, Color.fromRGBO(11, 59, 110, 1)],
                  colors: [Color.fromRGBO(201, 217, 190, 1), Color.fromRGBO(198,206,225, 1)],
                  // colors: [Color.fromRGBO(201, 217, 190, 1), Color.fromRGBO(11, 59, 110, 1)],
                  // colors: [Color.fromRGBO(221, 223, 220, 1), Color.fromRGBO(11, 59, 110, 1)],
                  // Color.fromRGBO(216, 214, 217, 1), Color.fromRGBO(153, 164, 188, 1)
                ),
              ),
              child: Expanded(
                child: Row(
                  children: [
                    LoginLeftPage(),
                    // Expanded(
                    //   child: Container(
                    //     // color: Color.fromRGBO(230, 242, 255, 1),
                    //   ),
                    // )  
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}