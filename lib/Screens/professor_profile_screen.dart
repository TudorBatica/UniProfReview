import 'dart:math';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/faculty_profile_screen.dart';
import 'package:professor_review/Screens/review_screen.dart';
import 'package:professor_review/Screens/university_profile_screen.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/entity_screen_header.dart';
import 'package:professor_review/widgets/information_list_tile.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/preview_list_tile.dart';
import 'package:provider/provider.dart';

class ProfessorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _professor = Provider.of<Professor>(context);

    // the information for the first tiles of this screen
    var informationDataList = <InformationListTileData>[
      InformationListTileData(
          icon: Icons.school, text: _professor.universityName),
      InformationListTileData(
          icon: Icons.location_city, text: _professor.facultyName),
      InformationListTileData(
          icon: Icons.check_box,
          text: _professor.reviews.length != 1
              ? _professor.reviews.length.toString() + " reviews"
              : _professor.reviews.length.toString() + " review")
    ];

    // what to happen when the info tiles are pressed
    var onTap = <Function>[
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider(
                  create: (_) => DatabaseService.instance
                      .university(_professor.universityReference),
                  child: UniversityProfileScreen()))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider(
                  create: (_) => DatabaseService.instance
                      .faculty(_professor.facultyReference),
                  child: FacultyProfileScreen()))),
      () {}
    ];

    return _professor == null
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
                      averageRating: _professor.averageRating,
                      averageRatingTitle: "Average rating",
                      entityName:
                          _professor.firstName + " " + _professor.lastName),
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
                          itemCount: _professor.reviews.length +
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
                                                  .review(_professor
                                                      .reviews[index -
                                                          informationDataList
                                                              .length]
                                                      .reviewReference),
                                              child: ReviewScreen()))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: PreviewListTile(
                                      data: PreviewListTileData(
                                          data: [
                                            InformationListTileData(
                                                icon: Icons.person_outline,
                                                text: _professor
                                                    .reviews[index -
                                                        informationDataList
                                                            .length]
                                                    .author),
                                            InformationListTileData(
                                                icon: Icons.chat,
                                                text: _professor
                                                    .reviews[index -
                                                        informationDataList
                                                            .length]
                                                    .title),
                                          ],
                                          rating: _professor
                                              .reviews[index -
                                                  informationDataList.length]
                                              .rating),
                                    ),
                                  ),
                                ))),
                )
              ],
            ),
          );
  }
}
