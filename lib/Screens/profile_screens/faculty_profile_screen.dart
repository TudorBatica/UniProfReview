import 'dart:math';

import 'package:flutter/material.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/models/professor_summary_data.dart';
import 'package:professor_review/screens/profile_screens/professor_profile_screen.dart';
import 'package:professor_review/screens/profile_screens/university_profile_screen.dart';
import 'package:professor_review/models/faculty.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/entity_screen_header.dart';
import 'package:professor_review/widgets/information_list_tile.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/preview_list_tile.dart';
import 'package:professor_review/widgets/profile_screen_header.dart';
import 'package:professor_review/widgets/title_and_rating_list_tile.dart';
import 'package:professor_review/widgets/two_weights_box.dart';
import 'package:provider/provider.dart';

class FacultyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _faculty = Provider.of<Faculty>(context);

    return _faculty == null
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // info header
                  _profileScreenHeader(context, _faculty),
                  // professors section
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Professors",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColorLight)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // reviews row
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: _professorsScrollView(context, _faculty.professors),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
          );
  }

  Widget _profileScreenHeader(context, Faculty faculty) {
    return ProfileScreenHeader(
      image: Image.asset('images/faculty.png'),
      information: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            faculty.name,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StreamProvider(
                        create: (_) => DatabaseService.instance
                            .university(faculty.universityReference),
                        child: UniversityProfileScreen()))),
            child: Text(
              faculty.universityName,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
        ],
      ),
      bottomInformation: TwoWeightsBox(
          boldedText: faculty.averageRating.toString(), normalText: "Rating"),
    );
  }

   Widget _professorsScrollView(context, professors) {
    // build the list of professors
    List<Widget> professorTiles = [];
    for (ProfessorSummaryData professor in professors) {
      // add the professor
      professorTiles.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StreamProvider(
                      create: (_) => DatabaseService.instance
                          .professor(professor.professorReference),
                      child: ProfessorProfileScreen(),
                    ))),
        child: TitleAndRatingListTile(
          image: Image.asset('images/professor.png'),
          rating: professor.averageRating.toString(),
          title: professor.firstName + " " + professor.lastName,
        ),
      ));
      // add some spacing
      professorTiles.add(SizedBox(width: 20.0));
    }
    // return a scrollable row with the list of reviews
    return SingleChildScrollView(
        scrollDirection: Axis.vertical, child: Row(children: professorTiles));
  }
  /*// the information for the info tiles of this screen
    var informationDataList = <InformationListTileData>[
      InformationListTileData(
          icon: Icons.school, text: _faculty.universityName),
      InformationListTileData(
          icon: Icons.location_on,
          text: _faculty.city + ", " + _faculty.country),
      InformationListTileData(
          icon: Icons.school,
          text: _faculty.professors.length != 1
              ? _faculty.professors.length.toString() + " professors"
              : _faculty.professors.length.toString() + " professor")
    ];

    // what to happen when the info tiles are pressed
    var onTap = <Function>[
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider(
                  create: (_) => DatabaseService.instance
                      .university(_faculty.universityReference),
                  child: UniversityProfileScreen()))),
      () {},
      () {}
    ];

    return _faculty == null
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0),
            body: Column(
              children: <Widget>[
                Center(
                  child: EntityScreenHeader(
                      averageRating: _faculty.averageRating,
                      averageRatingTitle: "Average rating",
                      entityName: _faculty.name),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                      ),
                      child: ListView.builder(
                          itemCount: _faculty.professors.length +
                              informationDataList.length,
                          itemBuilder: (context, index) => index <
                                  informationDataList.length
                              ? GestureDetector(
                                  onTap: onTap[index],
                                  child: InformationListTile(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    dividerLength:
                                        MediaQuery.of(context).size.width *
                                            (1 / pow(2, index + 1)),
                                    information: informationDataList[index],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StreamProvider(
                                              create: (_) => DatabaseService
                                                  .instance
                                                  .professor(_faculty
                                                      .professors[index -
                                                          informationDataList
                                                              .length]
                                                      .professorReference),
                                              child:
                                                  ProfessorProfileScreen()))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: PreviewListTile(
                                      data: PreviewListTileData(
                                          data: [
                                            InformationListTileData(
                                                icon: Icons.location_city,
                                                text: _faculty
                                                        .professors[index -
                                                            informationDataList
                                                                .length]
                                                        .firstName +
                                                    " " +
                                                    _faculty
                                                        .professors[index -
                                                            informationDataList
                                                                .length]
                                                        .lastName),
                                            InformationListTileData(
                                                icon: Icons.check_box,
                                                text: _faculty
                                                        .professors[index -
                                                            informationDataList
                                                                .length]
                                                        .numberOfReviews
                                                        .toString() +
                                                    " reviews"),
                                          ],
                                          rating: _faculty
                                              .professors[index -
                                                  informationDataList.length]
                                              .averageRating),
                                    ),
                                  ),
                                ))),
                )
              ],
            ),
          );*/
}
