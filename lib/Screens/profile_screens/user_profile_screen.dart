import 'package:flutter/material.dart';
import 'package:professor_review/models/review_summary_user.dart';
import 'package:professor_review/screens/review_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/loading.dart';
import 'package:professor_review/widgets/profile_screen_header.dart';
import 'package:professor_review/widgets/review_list_tile.dart';
import 'package:professor_review/widgets/two_weights_box.dart';
import 'package:provider/provider.dart';
import 'package:professor_review/models/user.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);

    return _user == null
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // user info header
                  ProfileScreenHeader(
                    image: Image.asset('images/user.png'),
                    information: Text(
                      _user.username,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    bottomInformation: TwoWeightsBox(
                        boldedText: _user.averageRating.toString(),
                        normalText: "Avg. Rating\nGiven"),
                  ),
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
                    child: _reviewsScrollView(context, _user.reviews),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
          );
  }

  Widget _reviewsScrollView(context, reviews) {
    // build the list of reviews
    List<Widget> reviewTiles = [];
    for (ReviewSummaryUser review in reviews) {
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
          middleText: 'for ' +
              review.professorsFirstName +
              " " +
              review.professorsLastName,
        ),
      ));
      // add some spacing
      reviewTiles.add(SizedBox(width: 20.0));
    }
    // return a scrollable row with the list of reviews
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: reviewTiles));
  }
}
