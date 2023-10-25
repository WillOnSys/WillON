import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_example/page/dashboard/dashboard.dart';
import 'package:ui_example/page/main/widgets/util.dart';

class WillONMainFrame extends StatefulWidget {
  @override
  _WillONMainFrameState createState() => _WillONMainFrameState();
}

class _WillONMainFrameState extends State<WillONMainFrame> {
  var _navigatorKey = GlobalKey<NavigatorState>();

  var _titleBox = () {
    return WindowTitleBarBox(
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
    );
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _titleBox(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color.fromRGBO(201, 217, 190, 1), Color.fromRGBO(198,206,225, 1)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RailBottonNavigation(_navigatorKey),
                  Expanded(
                    child: Navigator(
                      key: _navigatorKey,
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => () {
                          print(route.name);
                          return Text("Home");
                        }()
                      ),
                    ),
                  ),
                ],
              )
            ),
          )
        ],
      )
    );
  }
}

class RailBottonNavigation extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey;

  RailBottonNavigation(GlobalKey<NavigatorState> navigatorKey): _navigatorKey = navigatorKey;

  Future<void>? push(Route route) {
    print(route.isActive);
    return _navigatorKey.currentState?.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: 600.0,
        width: 80.0,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RailBotton(Icon(FontAwesomeIcons.home), "route to home",
                push(MaterialPageRoute(builder: (context) => Text("Home"))),
              ),
              SizedBox(height: 20,),
              RailBotton(Icon(Icons.data_exploration_outlined), "route to data", 
                push(MaterialPageRoute(builder: (context) => Text("Data"))),
              ),
              SizedBox(height: 20,),
              RailBotton(Icon(Icons.person_add_alt), "route to friends",
                push(MaterialPageRoute(builder: (context) => Text("Friends"))),
              ),
              SizedBox(height: 20,),
              RailBotton(Icon(Icons.messenger_outline), "route to message",
                push(MaterialPageRoute(builder: (context) => Text("Message"))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

