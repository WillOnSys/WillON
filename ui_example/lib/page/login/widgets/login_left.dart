import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_example/page/login/widgets/util.dart';
import 'package:ui_example/page/main/main_frame.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFormRoute extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormRoute> {
  final GlobalKey _loginKey = GlobalKey<FormState>();
  String? _defaultEmail;
  String? _defaultPaswd;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _paswdController = TextEditingController();
  bool _isRemember = false;

  var _loginContainer = (Widget? form) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: form,
    );
  };

  var _emailValidator = (value) {
    Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
    RegExp regExp = RegExp(pattern.toString());
    if (!regExp.hasMatch(value)) {
      return "Please entry valid email!";
    }
    return null;
  };
  var _passwdValidator = (value) {
    if (value.length < 8) {
      return "password is too short";
    }
    return null;
  };
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330.0,
      child: Form(
        key: _loginKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: _loginContainer(
                TextFormContainer(
                  "Your Email",
                  _emailController,
                  _emailValidator,
                  (value) {},
                  false,
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: _loginContainer(
                TextFormContainer(
                  "Your Passwd",
                  _paswdController,
                  _passwdValidator,
                  (value) {},
                  true,
                )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: _isRemember,
                        onChanged: (value) {
                          // TODO 编写逻辑
                          setState(() {
                            _isRemember = !_isRemember;
                          });
                        },
                      ),
                    ),
                    Text("Keep me logged in"),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: "Forgot password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.base);
                        print("recognizer forgot password");
                      },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 330.0,
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text("Log in"),
                      onPressed: () {
                        if ((_loginKey.currentState as FormState).validate()) {
                          // TODO 此处是上传业务
                          print("login: ${_emailController.text}\npasswd: ${_paswdController.text}");
                          if (_isRemember) {
                            // TODO 需要想一下keep的逻辑
                          }
                        }
                        _emailController.clear();
                        _paswdController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WillONMainFrame()),
                        );
                      },
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginLeftPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: 680.0,
        ),
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Here is trademark", style: TextStyle(fontSize: 20.0),),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text("Welcome Back", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            // TODO 表单设计
            LoginFormRoute(),
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 450.0,
                  height: 1,
                  color: Colors.black12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color.fromRGBO(200, 213, 204, 1), Color.fromRGBO(199, 210, 211, 1)],
                    ),
                  ),
                  child: Text("OR LOGIN WITH EMAIL", style: TextStyle(fontSize: 16.0, color: Colors.black38),)
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ThirdLoginButton(
                //   Image(image: AssetImage(
                //     "assets/logos/google_light.png",
                //     package: "flutter_signin_button"
                //   ),),
                //   "target link to google",
                // ),
                ThirdLoginButton(
                  Icon(FontAwesomeIcons.google),
                  "target link to google",
                ),
                SizedBox(width: 20,),
                ThirdLoginButton(
                  Icon(FontAwesomeIcons.github),
                  "target link to github",
                ),
                SizedBox(width: 20,),
                ThirdLoginButton(
                  Icon(FontAwesomeIcons.qq),
                  "target link to qq",
                ),
                SizedBox(width: 20,),
                ThirdLoginButton(
                  Icon(
                    FontAwesomeIcons.weixin,
                    // color: Colors.green,
                  ),
                  "target link to wechat",
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                SizedBox(width: 5.0,),
                RichText(
                  text: TextSpan(
                    text: "Sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.base);
                        print("recognizer sign up");
                      },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}