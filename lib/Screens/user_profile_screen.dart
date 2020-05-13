import 'package:flutter/material.dart';
import 'package:professor_review/Screens/review_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:professor_review/models/user.dart';

class UserProfileScreen extends StatelessWidget {
  final String userID;

  UserProfileScreen({Key key, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);

    return Scaffold(
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
        ));
  }
}
