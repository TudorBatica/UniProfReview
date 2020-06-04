import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  final Widget leadingText;
  final Widget trailingWidget;

  CustomAppBar({this.height, this.leadingText, this.trailingWidget});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0))),
        height: height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leadingText ?? SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: trailingWidget ?? SizedBox(),
                ),
              ],
            ),
          ),
        ));
  }
}
