//* the model class used to interact with
//* the review summary data stored in a
//* user's document

class ReviewSummaryUser {
  final String professorsFirstName;
  final String professorsLastName;
  final double rating;
  final String reviewReference;
  final String title;

  ReviewSummaryUser(
      {this.professorsFirstName,
      this.professorsLastName,
      this.rating,
      this.reviewReference,
      this.title});

  factory ReviewSummaryUser.fromMap(Map<String, dynamic> map) =>
      ReviewSummaryUser(
          professorsFirstName: map['prof_first_name'],
          professorsLastName: map['prof_last_name'],
          rating: map['rating'].toDouble(),
          reviewReference: map['review_ref'],
          title: map['title']);
}
