import 'package:flutter/material.dart';

class FilterBox extends StatefulWidget {
  final Function callback;
  FilterBox(this.callback);
  @override
  _FilterBoxState createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  RangeValues _currentRangeValues = RangeValues(10000, 500000);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        children: [
          Text('Filter By Price'),
          RangeSlider(
            values: _currentRangeValues,
            min: 10000, max: 500000,
            divisions: 5000,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString()
            ),
            onChanged: (RangeValues values){
              setState(() {
                _currentRangeValues = values;
              });
            }
            ),
            TextButton(onPressed: this.widget.callback(_currentRangeValues), child: Text('Filter'))
        ],
      ),
    );
  }
}
