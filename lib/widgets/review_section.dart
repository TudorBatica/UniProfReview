import 'package:flutter/material.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/widgets/information_list_tile.dart';

class ReviewSection extends StatelessWidget {
  final List<InformationListTileData> fields;
  final InformationListTileData title;

  const ReviewSection({Key key, this.fields, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // title container
        Container(
          height: MediaQuery.of(context).size.height * 0.075,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Icon(
                  title.icon,
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  size: 30.0,
                ),
              ),
              Text(
                title.text,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        // fields
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(color: Colors.grey, width: 2.0))),
            child: Column(
              children: _buildFieldsTiles(context),
            ),
          ),
        )
      ],
    );
  }

  // convert the tile data to tile widgets
  List<Widget> _buildFieldsTiles(context) => fields
      .map((field) => Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015,
                bottom: MediaQuery.of(context).size.height * 0.015),
            child: InformationListTile(
              dividerLength: 0,
              information: InformationListTileData(
                icon: field.icon,
                leadingText: field.leadingText,
                text: field.text,
              ),
            ),
          ))
      .toList();
}
