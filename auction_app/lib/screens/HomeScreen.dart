import 'package:auction_app/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
//
import '../widgets/MyAppBar.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('images/logo.jpg'),
        ),
        Container(
          child: MyCircularProgress()
        ),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, LoginScreen.id);
    }, child: Text('lo'))
      ],
    ));
  }
}

class MyCircularProgress extends StatefulWidget {
  @override
  _MyCircularProgressState createState() => _MyCircularProgressState();
}

class _MyCircularProgressState extends State<MyCircularProgress>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool isLoggedIn = false;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      print(status.index);
    });
    controller.animateTo(10);
    super.initState();
    print('hi');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Loading',
        ),
        Text('Loading'),
      ],
    );
  }
}
