import 'package:flutter/material.dart';
import 'package:professor_review/widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: SearchBar(
          height: MediaQuery.of(context).size.height * 0.0675,
          width: MediaQuery.of(context).size.width * 0.65,
          hintText: "Search professors or universities",
          autoFocus: true,
        ),
      ),
    );
  }
}
