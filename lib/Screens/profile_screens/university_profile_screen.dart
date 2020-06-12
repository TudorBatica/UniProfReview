import 'package:flutter/material.dart';
import 'package:professor_review/models/faculty_summary_data.dart';
import 'package:professor_review/screens/profile_screens/faculty_profile_screen.dart';
import 'package:professor_review/models/university.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/profile_screen_header.dart';
import 'package:professor_review/widgets/title_and_rating_list_tile.dart';
import 'package:professor_review/widgets/two_weights_box.dart';
import 'package:provider/provider.dart';

class UniversityProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _university = Provider.of<University>(context);

    return _university == null
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // info header
                  _profileScreenHeader(context, _university),
                  // faculties section
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Faculties",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColorLight)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // faculties row
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: _facultiesScrollView(context, _university.faculties),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
          );
  }

  Widget _profileScreenHeader(context, University university) {
    return ProfileScreenHeader(
      image: Image.asset('images/university.jpg'),
      information: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            university.name,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "${university.city}, ${university.country}",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
      bottomInformation: TwoWeightsBox(
          boldedText: university.averageRating.toString(),
          normalText: "Rating"),
    );
  }

  Widget _facultiesScrollView(context, faculties) {
    // build the list of professors
    List<Widget> facultyTiles = [];
    for (FacultySummaryData faculty in faculties) {
      // add the professor
      facultyTiles.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StreamProvider(
                      create: (_) => DatabaseService.instance
                          .faculty(faculty.facultyReference),
                      child: FacultyProfileScreen(),
                    ))),
        child: TitleAndRatingListTile(
          image: Image.asset('images/faculty.png'),
          rating: faculty.averageRating.toString(),
          title: faculty.facultyName,
        ),
      ));
      // add some spacing
      facultyTiles.add(SizedBox(width: 20.0));
    }
    // return a scrollable row with the list of reviews
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: facultyTiles));
  }
}
