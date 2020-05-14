import 'package:flutter/material.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/widgets/review_section.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _review = Provider.of<Review>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Center(
                child: Text(
                  _review.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30.0),
              ReviewSection(
                title: InformationListTileData(
                    icon: Icons.school, text: "Professor"),
                fields: [
                  InformationListTileData(
                      icon: Icons.person_outline,
                      text: _review.professorFirstName +
                          " " +
                          _review.professorLastName),
                  InformationListTileData(
                      icon: Icons.location_city, text: _review.facultyName),
                  InformationListTileData(
                      icon: Icons.school, text: _review.universityName),
                ],
              ),
              ReviewSection(
                title:
                    InformationListTileData(icon: Icons.edit, text: "Author"),
                fields: [
                  InformationListTileData(
                      icon: Icons.person_outline, text: _review.author),
                ],
              ),
              ReviewSection(
                title: InformationListTileData(
                    icon: Icons.thumbs_up_down, text: "Pros & Cons"),
                fields: [
                  InformationListTileData(
                      icon: Icons.thumb_up, text: _review.pros),
                  InformationListTileData(
                      icon: Icons.thumb_down, text: _review.cons),
                ],
              ),
              ReviewSection(
                title: InformationListTileData(
                    icon: Icons.looks_6, text: "Ratings"),
                fields: [
                  InformationListTileData(
                      leadingText: _review.courseSubjectsRating.toString(),
                      text: "Course subjects rating"),
                  InformationListTileData(
                      leadingText: _review.explanationsRating.toString(),
                      text: "Explanations rating"),
                  InformationListTileData(
                      leadingText: _review.punctualityRating.toString(),
                      text: "Punctuality rating"),
                ],
              ),
              SizedBox(height: 30.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                //height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "Average rating",
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      _review.rating.toString(),
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ));
  }
}
