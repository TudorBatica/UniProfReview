import 'package:flutter/material.dart';

class TwoWeightsBox extends StatelessWidget {
  //* A container that holds some bold text and top
  //* and some lighter text at the bottom

  final String boldedText;
  final String normalText;

  const TwoWeightsBox({Key key, this.boldedText, this.normalText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(boldedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0)),
              Text(normalText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0))
            ],
          ),
        ));
  }
}
