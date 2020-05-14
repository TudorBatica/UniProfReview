import 'dart:math';
import 'package:flutter/material.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';
import 'package:professor_review/widgets/entity_screen_header.dart';
import 'package:professor_review/widgets/information_list_tile.dart';
import 'package:professor_review/widgets/preview_list_tile.dart';

class EntityProfileScreen extends StatelessWidget {
  final String averageRatingTitle;
  final double averageRating;
  final String entityName;
  final List<InformationListTileData> informationListTilesData;
  final List<PreviewListTileData> previewListTilesData;

  const EntityProfileScreen(
      {Key key,
      this.averageRatingTitle,
      this.averageRating,
      this.entityName,
      this.informationListTilesData,
      this.previewListTilesData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 0, 0.7)),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: EntityScreenHeader(
            averageRating: averageRating,
            averageRatingTitle: averageRatingTitle,
            entityName: entityName,
          )),
          SizedBox(height: 25),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                      itemCount: informationListTilesData.length +
                          previewListTilesData.length,
                      itemBuilder: (context, index) => index <
                              informationListTilesData.length
                          ? InformationListTile(
                              information: informationListTilesData[index],
                              height: MediaQuery.of(context).size.height * 0.1,
                              dividerLength: MediaQuery.of(context).size.width *
                                  (1 / pow(2, index + 1)),
                            )
                          : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: PreviewListTile(
                               data: previewListTilesData[index - informationListTilesData.length]
                              ),
                          ))))
        ],
      ),
    );
  }
}
