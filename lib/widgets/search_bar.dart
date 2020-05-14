import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final bool autoFocus;
  final double height;
  final String hintText;
  final double hintTextFontSize;
  final Function onTap;
  final double width;

  const SearchBar(
      {Key key,
      this.width,
      this.hintText,
      this.hintTextFontSize,
      this.onTap,
      this.autoFocus,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: autoFocus,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: hintTextFontSize),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent)),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
