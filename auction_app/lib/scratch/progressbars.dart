import 'package:flutter/material.dart';
import 'dart:async';

class PorgressBar1 extends StatefulWidget {
  @override
  _PorgressBar1State createState() => _PorgressBar1State();
}

class _PorgressBar1State extends State<PorgressBar1> {
  bool _status = false;
  @override
  void initState() {
    // TODO check token
    Future.delayed(
        const Duration(seconds: 5),
        () => {
              // TODO naviage to some thing
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _status
        ? CircularProgressIndicator(
            backgroundColor: Colors.red,
            strokeWidth: 8,
          )
        : Text('Done');
  }
}

void _updateProgress() {
  double progressValue = 0.0;
  bool loading = true;
  const fiveSec = const Duration(seconds: 5);
  Timer.periodic(fiveSec, (Timer t) {
    // set state
    progressValue += 0.2;
    if (progressValue.toStringAsFixed(1) == '1.0') {
      loading = false;
      t.cancel();
      return;
    }
  });
  // check if 100%
}

int value = 6;
var mySlider = Slider(
  value: value.toDouble(),
  min: 1.0,
  max: 20.0,
  divisions: 10,
  activeColor: Colors.green,
  inactiveColor: Colors.orange,
  semanticFormatterCallback: (double newValue) {
    return '${newValue.round()}';
  },
  label: 'Set something',
  onChanged: (double newValue) {
    value = newValue.round();
  },
);

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

class AnotherProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: new CircularProgressIndicator(
                      strokeWidth: 15,
                      value: 1.0,
                    ),
                  ),
                ),
                Center(child: Text("Test")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
