import 'package:flutter/material.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/services/review_submission_service.dart';

class SubmitReviewScreen extends StatefulWidget {
  final Professor professor;

  SubmitReviewScreen({Key key, this.professor}) : super(key: key);

  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  Review _review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0, backgroundColor: Theme.of(context).primaryColor),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  // header container
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Submit a review for",
                        style: TextStyle(color: Colors.white, fontSize: 26.0),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        widget.professor.firstName +
                            " " +
                            widget.professor.lastName,
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      )
                    ],
                  )),
              SizedBox(height: 20.0),
              TextFormField(
                maxLengthEnforced: true,
                maxLength: 90,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
                decoration: InputDecoration(hintText: 'Title'),
                onChanged: (value) => _review.title = value,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      )
                      )
                    ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                onPressed: () {
                  ReviewSubmissionService.instance.submitReview(
                    widget.professor, Review(
                      title: "Ion was born to be a professor",
                      courseSubjectsRating: 5.0,
                      examsDifficultyRating: 5.0,
                      explanationsRating: 5.0,
                      punctualityRating: 5.0,
                      rating: 5.0,
                      cons: "none",
                      pros: "everything"
                    ));
                },
              )
            ],
          ),
        ));
  }
}
