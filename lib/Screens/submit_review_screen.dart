import 'package:flutter/material.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/models/user.dart';
import 'package:professor_review/services/review_submission_service.dart';
import 'package:professor_review/widgets/custom_app_bar.dart';
import 'package:professor_review/widgets/entity_box.dart';
import 'package:professor_review/widgets/two_weights_box.dart';
import 'package:provider/provider.dart';

class SubmitReviewScreen extends StatefulWidget {
  final Professor professor;
  final String currentUserID;
  SubmitReviewScreen({Key key, this.professor, this.currentUserID})
      : super(key: key);

  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  String _title;
  String _pros;
  String _cons;
  double _courseSubjectsRating = 5.0;
  double _explanationsRating = 5.0;
  double _punctualityRating = 5.0;

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: _reviewScreenAppBar(context),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // information header
          SizedBox(height: 10),
          Center(
            child: EntityBox(
              context: context,
              image: AssetImage('images/professor.png'),
              title: "Professor",
              name:
                  widget.professor.firstName + " " + widget.professor.lastName,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // title field
          TextField(
            decoration: InputDecoration(
                hintText: 'Review Title',
                hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0)),
            maxLines: null,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            onChanged: (title) => _title = title,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // pros field
          TextField(
            decoration: InputDecoration(
                hintText: 'Pros',
                hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0)),
            maxLines: null,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            onChanged: (value) => _pros = value,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // cons field
          TextField(
            decoration: InputDecoration(
                hintText: 'Cons',
                hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0)),
            maxLines: null,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            onChanged: (value) => _cons = value,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          //course subjects rating
          Text(
            'Rate course subjects',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(_courseSubjectsRating.toStringAsFixed(2),
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Slider(
            value: _courseSubjectsRating,
            onChanged: (value) => setState(() => _courseSubjectsRating = value),
            min: 1.0,
            max: 10.0,
            activeColor: Theme.of(context).primaryColorLight,
            inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          //explanations rating
          Text(
            'Rate explanations',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(_explanationsRating.toStringAsFixed(2),
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Slider(
            value: _explanationsRating,
            onChanged: (value) => setState(() => _explanationsRating = value),
            min: 1.0,
            max: 10.0,
            activeColor: Theme.of(context).primaryColorLight,
            inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          //punctuality rating
          Text(
            'Rate punctuality',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(_punctualityRating.toStringAsFixed(2),
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Slider(
            value: _punctualityRating,
            onChanged: (value) => setState(() => _punctualityRating = value),
            min: 1.0,
            max: 10.0,
            activeColor: Theme.of(context).primaryColorLight,
            inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.055),
          // submit button
          GestureDetector(
            onTap: () {
              _courseSubjectsRating =
                  double.parse(_courseSubjectsRating.toStringAsFixed(2));
              _explanationsRating =
                  double.parse(_explanationsRating.toStringAsFixed(2));
              _punctualityRating =
                  double.parse(_punctualityRating.toStringAsFixed(2));
              double averageRating = (_courseSubjectsRating +
                      _explanationsRating +
                      _punctualityRating) / 3;
              averageRating = double.parse(averageRating.toStringAsFixed(2));

              var review = Review(
                  author: _user.username,
                  authorReference: widget.currentUserID,
                  cons: _cons,
                  courseSubjectsRating: _courseSubjectsRating,
                  explanationsRating: _explanationsRating,
                  facultyName: widget.professor.facultyName,
                  facultyReference: widget.professor.facultyReference,
                  professorFirstName: widget.professor.firstName,
                  professorLastName: widget.professor.lastName,
                  professorReference: widget.professor.documentReference,
                  pros: _pros,
                  punctualityRating: _punctualityRating,
                  rating: averageRating,
                  title: _title,
                  universityName: widget.professor.universityName,
                  universityReference: widget.professor.universityReference);
              
              ReviewSubmissionService.instance.submitReview(review);
            },
            child: TwoWeightsBox(
              boldedText: "Submit",
              normalText: "Review",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.055),
        ]),
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

  
}
