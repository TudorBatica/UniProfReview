import 'package:flutter/material.dart';
import 'package:professor_review/models/information_list_tile_data.dart';

class InformationListTile extends StatelessWidget {

  final double dividerLength;
  final InformationListTileData information;
  final double height;
  
  const InformationListTile({Key key, this.height, this.information, this.dividerLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(child: Icon(
                    information.icon, 
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    size: 30,
                  ))),
              Text(
                information.text,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  fontSize: 22.0
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            width: dividerLength,
            color: Color.fromRGBO(0, 0, 0, 0.8)
          )
        ],
      ),
    );
  }
}
