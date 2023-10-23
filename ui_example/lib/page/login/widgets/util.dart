import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdLoginButton extends StatelessWidget {
  final Widget? _loginImage;
  final String? _tapString; // TODO 后期修改为逻辑

  const ThirdLoginButton(Widget? loginImage, String? tapString): _loginImage = loginImage, _tapString = tapString;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(_tapString);
        launchUrl(Uri.base);
      },
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0
          )
        ),
        child: ClipOval(
          child: _loginImage,
        )
      ),
    );
  }
}

class TextFormContainer extends StatelessWidget {
  final String? _hintText;
  final TextEditingController? _controller; 
  final String? Function(String?)? _validator;
  final void Function(String?)? _onSaved;
  final bool _obscure;

  TextFormContainer(String? hintText, TextEditingController? controller, String? validator(String)?, void onSaved(String)?, bool obscure)
    : _hintText = hintText, _controller = controller, _validator = validator
    , _onSaved = onSaved, _obscure = obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: _hintText,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        // border: InputBorder.none,
        border: OutlineInputBorder(),
        
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0)
        ),
      ),
      obscureText: _obscure,
      validator: _validator,
      onSaved: _onSaved,
    );
  }
}