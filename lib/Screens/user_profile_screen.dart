import 'package:flutter/material.dart';
import 'package:professor_review/Screens/entity_profile_screen.dart';
import 'package:professor_review/Screens/review_screen.dart';
import 'package:professor_review/models/information_list_tile_data.dart';
import 'package:professor_review/models/preview_list_tile_data.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/entity_screen_header.dart';
import 'package:professor_review/widgets/information_list_tile.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/preview_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:professor_review/models/user.dart';
import 'dart:math';

class UserProfileScreen extends StatelessWidget {
  final String userID;

  UserProfileScreen({Key key, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);

    return _user == null
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
                      averageRating: _user.averageRating,
                      averageRatingTitle: "Gives an average rating of",
                      entityName: _user.username),
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
                          itemCount: _user.reviews.length + 1,
                          itemBuilder: (context, index) => index < 1
                              ? InformationListTile(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  dividerLength:
                                      MediaQuery.of(context).size.width *
                                          (1 / pow(2, index + 1)),
                                  information: InformationListTileData(
                                      icon: Icons.chat,
                                      text: _user.reviews.length != 1
                                          ? _user.reviews.length.toString() +
                                              " reviews"
                                          : _user.reviews.length.toString() +
                                              " review"),
                                )
                              : GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StreamProvider(
                                              create: (_) => DatabaseService
                                                  .instance
                                                  .review(_user
                                                      .reviews[index - 1]
                                                      .reviewReference),
                                              child: ReviewScreen()))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: PreviewListTile(
                                      data: PreviewListTileData(
                                          data: [
                                            InformationListTileData(
                                                icon: Icons.person_outline,
                                                text: _user.reviews[index - 1]
                                                        .professorsFirstName +
                                                    " " +
                                                    _user.reviews[index - 1]
                                                        .professorsLastName),
                                            InformationListTileData(
                                                icon: Icons.chat,
                                                text: _user
                                                    .reviews[index - 1].title),
                                          ],
                                          rating:
                                              _user.reviews[index - 1].rating),
                                    ),
                                  ),
                                ))),
                )
              ],
            ),
          );

    /*Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor, elevation: 0.0),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("username: " + _user.username),
              SizedBox(height: 20),
              Text("average rating given: " + _user.averageRating.toString()),
              SizedBox(height: 20),
              Text("reviews: "),
              Expanded(
                  child: ListView.builder(
                      itemCount: _user.reviews.length,
                      itemBuilder: (context, index) => Container(
                            color: Colors.grey,
                            child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StreamProvider(
                                            create: (_) => DatabaseService.instance
                                                .review(_user.reviews[index]
                                                    .reviewReference),
                                            child: ReviewScreen()))),
                                leading: Text(
                                    _user.reviews[index].rating.toString()),
                                enabled: true,
                                title: Center(
                                    child: Text(
                                        _user.reviews[index].reviewReference)),
                                trailing:
                                    Text(_user.reviews[index].professorsFirstName + " " + _user.reviews[index].professorsLastName)),
                          )))
            ],
          ),
        ));*/
  }
}
