import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  final String label;
  final Function callback;
  RowButton({
    @required this.label,@required  this.callback
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(),
      onPressed: callback,
      child: Text(label),
    );
  }
}
