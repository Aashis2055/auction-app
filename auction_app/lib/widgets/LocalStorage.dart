import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SomeWidget extends StatelessWidget {
  final LocalStorage storage = LocalStorage('the key');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          Map<String, dynamic> data = storage.getItem('key');
          return Container(
            child: Text(data['name']),
          );
        } else {
          // return some Loading State Widget
          return Container(
            child: Text('Noting'),
          );
        }
      },
    );
  }
}
