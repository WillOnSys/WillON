import 'package:flutter/material.dart';

class RailBotton extends StatelessWidget {
  final Widget? _bottonImage;
  final String? _tapString; // TODO 后期修改为路由页面
  final _onAction;

  const RailBotton(Widget? bottonImage, String? tapString, onAction)
    : _bottonImage = bottonImage, _tapString = tapString, _onAction = onAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(_tapString);
        _onAction();
      },
      child: Container(
        width: 45.0,
        height: 45.0,
        // color: Colors.white,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: ClipOval(child: _bottonImage,),
      ),
    );
  }
}