import 'package:flutter/material.dart';
import 'package:professor_review/widgets/two_part_card.dart';

class TitleAndRatingListTile extends StatelessWidget {
  final Image image;
  final String title;
  final String rating;

  const TitleAndRatingListTile({Key key, this.title, this.rating, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TwoPartCard(
      width: MediaQuery.of(context).size.width * 0.8,
      image: image,
      imageHeight: MediaQuery.of(context).size.height * 0.2,
      imageWidth: MediaQuery.of(context).size.width * 0.8,
      bottom: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 16.0,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(" " + rating.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColorLight)),
                  Text(" Rating",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColorLight))
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(80.0)),
          )
        ],
      ),
    );
  }
}
