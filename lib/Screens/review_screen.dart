import 'package:flutter/material.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/screens/profile_screens/professor_profile_screen.dart';
import 'package:professor_review/screens/profile_screens/user_profile_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/custom_app_bar.dart';
import 'package:professor_review/widgets/entity_box.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _review = Provider.of<Review>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: _reviewScreenAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // author and professor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StreamProvider(
                                  create: (_) => DatabaseService.instance
                                      .userProfile(_review.authorReference),
                                  child: UserProfileScreen(),
                                ))),
                    child: EntityBox(
                      context: context,
                      image: AssetImage('images/user.png'),
                      title: "Review Author",
                      name: _review.author,
                    )),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StreamProvider(
                                create: (_) => DatabaseService.instance
                                    .professor(_review.professorReference),
                                child: ProfessorProfileScreen(),
                              ))),
                  child: EntityBox(
                      context: context,
                      title: "Professor",
                      name: _review.professorFirstName +
                          " " +
                          _review.professorLastName,
                      image: AssetImage('images/professor.png')),
                )
              ],
            ),
            // divider
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Container(
              color: Theme.of(context).primaryColorLight,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 4,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // title
            Text(_review.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // pros section
            _reviewInformationContainer(
                context,
                "Pros",
                Text(_review.pros,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.0))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // cons section
            _reviewInformationContainer(
                context,
                "Cons",
                Text(_review.cons,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.0))),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // ratings section
            _reviewInformationContainer(
                context,
                "Ratings",
                Column(
                  children: <Widget>[
                    _ratingContainer(context, "Course Subjects",
                        _review.courseSubjectsRating),
                    _ratingContainer(
                        context, "Explanations", _review.explanationsRating),
                    _ratingContainer(
                        context, "Punctuality", _review.punctualityRating),
                    Container(
                      color: Theme.of(context).primaryColorDark,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 4,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _ratingContainer(context, "Average Rating", _review.rating),
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          ],
        ),
      ),
    );
  }

  Widget _reviewScreenAppBar(context) {
    return CustomAppBar(
        height: MediaQuery.of(context).size.height * 0.11,
        leadingText: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(1000.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        trailingWidget: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: RichText(
              text: TextSpan(
                  text: "Re",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0),
                  children: [
                TextSpan(
                  text: "view",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w900),
                )
              ])),
        ));
  }

  // used to store review information
  Widget _reviewInformationContainer(context, title, information) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(20.0)),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  boxShadow: [BoxShadow(blurRadius: 5.0)]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(child: information),
          )
        ],
      ),
    );
  }

  // used to display a rating
  Widget _ratingContainer(context, name, rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                    child: Text(rating.toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0)))),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0)),
            )
          ],
        ),
      ),
    );
  }
}
