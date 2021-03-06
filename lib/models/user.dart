import 'package:professor_review/models/review_summary_user.dart';

class User {
  final double averageRating;
  final List<ReviewSummaryUser> reviews;
  final String username;

  User({this.username, this.averageRating, this.reviews});

  factory User.fromMap(Map<String, dynamic> map) {
    var usersReviews = List<ReviewSummaryUser>();
    if(map['reviews'] != null) {
      usersReviews = map['reviews'].map<ReviewSummaryUser>((review) => ReviewSummaryUser.fromMap(review)).toList();
    }
    return User(
        averageRating: map['avg_rating'].toDouble(),
        reviews: usersReviews,
        username: map['username']);
  }
}
