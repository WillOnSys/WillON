/// This is main file to start WillON UI project
/// @author Chen Miao
/// @date 2023/10/11

import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:ui_example/page/login/login.dart';

/**
 * @author Chen Miao
 * @data 2023/10/11
 * @brief A main class that guides the project to start
 */
class WillON extends StatelessWidget {
  const WillON({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade400),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: LoginPage(),
      // home: LoginPage(),
    );
  }
}

void main() {
  runApp(
    const WillON(),
  );
  doWhenWindowReady(() {
    // const initialSize = Size(1440, 680);
    // appWindow.minSize = initialSize;
    // appWindow.size = initialSize;
    appWindow.show();
  });
}
