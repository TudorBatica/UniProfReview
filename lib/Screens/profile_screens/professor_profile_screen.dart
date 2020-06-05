import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/models/review_summary_professor.dart';
import 'package:professor_review/screens/profile_screens/faculty_profile_screen.dart';
import 'package:professor_review/screens/review_screen.dart';
import 'package:professor_review/screens/profile_screens/university_profile_screen.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/screens/submit_review_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/profile_screen_header.dart';
import 'package:professor_review/widgets/review_list_tile.dart';
import 'package:professor_review/widgets/two_weights_box.dart';
import 'package:provider/provider.dart';

class ProfessorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _professor = Provider.of<Professor>(context);
    var _user = Provider.of<FirebaseUser>(context);
    return _professor == null
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // professor info header
                  _profileScreenHeader(context, _professor, _user.uid),
                  // reviews section
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Reviews",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColorLight)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // reviews row
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: _reviewsScrollView(context, _professor.reviews),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
          );
  }

  ProfileScreenHeader _profileScreenHeader(context, professor, userID) {
    return ProfileScreenHeader(
      image: Image.asset('images/professor.png'),
      information: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            professor.firstName + " " + professor.lastName,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StreamProvider(
                        create: (_) => DatabaseService.instance
                            .university(professor.universityReference),
                        child: UniversityProfileScreen()))),
            child: Text(
              professor.universityName,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StreamProvider(
                        create: (_) => DatabaseService.instance
                            .faculty(professor.facultyReference),
                        child: FacultyProfileScreen()))),
            child: Text(
              professor.facultyName,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
        ],
      ),
      bottomInformation: Row(
        children: <Widget>[
          TwoWeightsBox(
              boldedText: professor.averageRating.toString(),
              normalText: "Rating"),
          SizedBox(width: MediaQuery.of(context).size.width * 0.025),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamProvider(
                    create: (_) => DatabaseService.instance.userProfile(userID),
                    child: SubmitReviewScreen(
                      professor: professor,
                      currentUserID: userID,
                    ),
                  ),
                )),
            child: TwoWeightsBox(boldedText: "Add", normalText: "Review"),
          )
        ],
      ),
    );
  }

  Widget _reviewsScrollView(context, reviews) {
    // build the list of reviews
    List<Widget> reviewTiles = [];
    for (ReviewSummaryProfessor review in reviews) {
      // add the review
      reviewTiles.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StreamProvider(
                      create: (_) => DatabaseService.instance
                          .review(review.reviewReference),
                      child: ReviewScreen(),
                    ))),
        child: ReviewListTile(
            title: review.title,
            rating: review.rating,
            middleText: 'by ' + review.author),
      ));
      // add some spacing
      reviewTiles.add(SizedBox(width: 20.0));
    }
    // return a scrollable row with the list of reviews
    return SingleChildScrollView(
        scrollDirection: Axis.vertical, child: Row(children: reviewTiles));
  }
}
