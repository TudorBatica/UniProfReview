import 'package:flutter/material.dart';

// the main button used in the app

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final double width;
  final Text text;
  final Icon icon;

  CustomButton(
      {Key key, this.onPressed, this.height, this.width, this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        child: Container(
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (icon != null) ...[icon],
              if (text != null) ...[text]
            ],
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2.5)),
        ));
  }
}
