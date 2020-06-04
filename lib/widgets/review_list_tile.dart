import 'package:flutter/material.dart';
import 'package:professor_review/widgets/two_part_card.dart';

class ReviewListTile extends StatelessWidget {
  final String middleText;
  final double rating;
  final String title;

  const ReviewListTile({Key key, this.middleText, this.rating, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TwoPartCard(
      width: MediaQuery.of(context).size.width * 0.8,
      image: Image.asset('images/review.png'),
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
          Text(
            middleText,
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
