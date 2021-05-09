import 'package:flutter/material.dart';

// background view for login and register screen
class Background1 extends StatelessWidget {
  final Widget child;
  const Background1({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[child],
            ),
          ),
        ),
      ),
    );
  }
}
// Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Image.asset("assets/images/main_top.png",
//                     width: size.width * 0.3)),
//             Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: Image.asset(
//                   "assets/images/main_bottom.png",
//                   width: size.width * 0.2,
//                 )),
