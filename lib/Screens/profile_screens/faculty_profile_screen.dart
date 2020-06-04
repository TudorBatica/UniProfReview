import 'dart:math';

import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

class FacultyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _faculty = Provider.of<Faculty>(context);

    // the information for the info tiles of this screen
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
          );
  }
}
