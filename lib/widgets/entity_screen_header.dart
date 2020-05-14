import 'package:flutter/material.dart';

class EntityScreenHeader extends StatelessWidget {

  final double averageRating;
  final String averageRatingTitle;
  final String entityName;

  const EntityScreenHeader({Key key, this.averageRating, this.averageRatingTitle, this.entityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
          Text(
            entityName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              fontSize: 28.0,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 1,
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          Text(
            averageRatingTitle, 
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              fontSize: 20.0,
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Text(
            averageRating.toString(),
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              fontSize: 28.0,
              fontWeight: FontWeight.bold
            )
          )
        ],);
  }
}