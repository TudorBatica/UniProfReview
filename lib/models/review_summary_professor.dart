//* the model class used to interact with
//* the review summary data stored in a
//* professors's document

class ReviewSummaryProfessor {
  final String author;
  final double rating;
  final String reviewReference;
  final String title;

  ReviewSummaryProfessor(
      {this.author, this.rating, this.reviewReference, this.title});

  factory ReviewSummaryProfessor.fromMap(Map<String, dynamic> map) =>
      ReviewSummaryProfessor(
          author: map['author'],
          rating: map['rating'].toDouble(),
          reviewReference: map['review_reference'],
          title: map['title']);
}
