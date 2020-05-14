import 'package:flutter/material.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';

class PreviewListTile extends StatelessWidget {
  final PreviewListTileData data;

  const PreviewListTile({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: data.onTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(children: _dataToWidget(context)),
      ),
    );
  }

  // converts the data passed to a list of widgets
  // that will be used in the main container that
  // represents the preview list tile
  List<Container> _dataToWidget(context) {
    var widgets = new List<Container>();

    for (var row in data.data) {
      widgets.add(Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Icon(
                        row.icon,
                        size: 30.0,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    row.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.8), fontSize: 20.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(0, 0, 0, 0.7),
                    Theme.of(context).primaryColor
                  ])),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Color.fromRGBO(0, 0, 0, 0.7)
                  ])),
                ),
              ],
            )
          ],
        ),
      ));
    }

    var icon;
    if (data.rating < 5) {
      icon = Icons.mood_bad;
    } else if (data.rating < 8) {
      icon = Icons.sentiment_neutral;
    } else {
      icon = Icons.mood;
    }

    // add the rating row
    widgets.add(Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  data.rating.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      fontSize: 20.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));

    return widgets;
  }
}
