import 'dart:math';

import 'package:flutter/material.dart';
import 'package:professor_review/Screens/faculty_profile_screen.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';
import 'package:professor_review/models/university.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/entity_screen_header.dart';
import 'package:professor_review/widgets/information_list_tile.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/preview_list_tile.dart';
import 'package:provider/provider.dart';

class UniversityProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _university = Provider.of<University>(context);

    // the information for the info tiles of this screen
    var informationDataList = <InformationListTileData>[
      InformationListTileData(
          icon: Icons.location_on,
          text: _university.city + ", " + _university.country),
      InformationListTileData(
          icon: Icons.school,
          text: _university.faculties.length != 1
              ? _university.faculties.length.toString() + " faculties"
              : _university.faculties.length.toString() + " faculty")
    ];

    return _university == null
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
                      averageRating: _university.averageRating,
                      averageRatingTitle: "Average rating",
                      entityName: _university.name),
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
                          itemCount: _university.faculties.length +
                              informationDataList.length,
                          itemBuilder: (context, index) => index <
                                  informationDataList.length
                              ? InformationListTile(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  dividerLength:
                                      MediaQuery.of(context).size.width *
                                          (1 / pow(2, index + 1)),
                                  information: informationDataList[index],
                                )
                              : GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StreamProvider(
                                              create: (_) => DatabaseService
                                                  .instance
                                                  .faculty(_university
                                                      .faculties[index -
                                                          informationDataList
                                                              .length]
                                                      .facultyReference),
                                              child: FacultyProfileScreen()))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: PreviewListTile(
                                      data: PreviewListTileData(
                                          data: [
                                            InformationListTileData(
                                                icon: Icons.location_city,
                                                text: _university
                                                    .faculties[index -
                                                        informationDataList
                                                            .length]
                                                    .facultyName),
                                          ],
                                          rating: _university
                                              .faculties[index -
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
