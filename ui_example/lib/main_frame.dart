import 'package:flutter/material.dart';

class WillONMainFrame extends StatefulWidget {
  @override
  WillONMainFrameState createState() => WillONMainFrameState();
}

class WillONMainFrameState extends State<WillONMainFrame> {
  num _chooseAppIdx = 0, _chooseSetIdx = 0;

  late List<NavigationRailDestination> _applicationList = [
    _navigationDest(Icon(Icons.dashboard), Text('Dashboard')),
    _navigationDest(Icon(Icons.folder_copy), Text('All Blogs')),
    _navigationDest(Icon(Icons.chat_rounded), Text('Messages')),
    _navigationDest(Icon(Icons.people_outline), Text('Friends')),
    _navigationDest(Icon(Icons.schedule_outlined), Text('Schedule')),
  ];
  late List<NavigationRailDestination> _settingList = [
    _navigationDest(Icon(Icons.settings), Text('Settings')), 
    _navigationDest(Icon(Icons.info_outline), Text('Directory'))
  ];
  
  var _navigationDest = (Icon icon, Text text) {
    return NavigationRailDestination(icon: icon, label: text);
  };
  var _navigationBox = (double width, double height, Color? bgColor, 
    List<NavigationRailDestination> navigationDestList, num selectedIndex, Function setFunc) {
    return SizedBox(
      width: width,
      height: height,
      child: SafeArea(
        child: NavigationRail(
          backgroundColor: bgColor,
          extended: true,
          destinations: navigationDestList,
          selectedIndex: selectedIndex as int,
          onDestinationSelected: (int? value) {
            setFunc(value);
          }
        ),
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    Widget appPage = switch(_chooseAppIdx) {
      0 => Scaffold(body: Text("dashdoard"),),
      1 => Scaffold(body: Text("all blogs"),),
      2 => Scaffold(body: Text("messages"),),
      3 => Scaffold(body: Text("friends"),),
      4 => Scaffold(body: Text("schedule"),),
      _ => Scaffold(body: Text("Error"),),
    };
    Widget setPage = switch(_chooseSetIdx) {
      0 => Scaffold(body: Text("Settings"),),
      1 => Scaffold(body: Text("Directory"),),
      _ => Scaffold(body: Text("Error"),),
    };
    return LayoutBuilder(builder: (context, constraints) {
        var _baseColorTheme = Theme.of(context).colorScheme.primaryContainer;
        return Scaffold(
          backgroundColor: _baseColorTheme,
          body: Row(
            children: [
              SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 40.0, 100.0, 40.0),
                        child: Text('Will ON', style: TextStyle(fontSize: 32.0),),
                      ),
                      _navigationBox(200, 300, _baseColorTheme, _applicationList, _chooseAppIdx, (value){
                        setState(() {
                          _chooseAppIdx = value;
                        });
                      }),
                      SizedBox(
                        height: 100,
                      ),
                      _navigationBox(200, 100, _baseColorTheme, _settingList, _chooseSetIdx, (value){
                        setState(() {
                          _chooseSetIdx = value;
                        });
                      }),
                    ],
                  ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  // TODO 这里需要构思一个良构去解决app和set page的冲突
                  // TIPS 可以采取使用反射
                  // child: switch (appPage) {

                  // },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}