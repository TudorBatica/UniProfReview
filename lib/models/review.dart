class Review {
  String title;
  String pros;
  String cons;
  double courseSubjectsRating;
  double explanationsRating;
  double examsDifficultyRating;
  double punctualityRating;
  double rating;

  Review(
      {this.title,
      this.pros,
      this.cons,
      this.courseSubjectsRating,
      this.explanationsRating,
      this.examsDifficultyRating,
      this.punctualityRating,
      this.rating});

  Map<String, dynamic> get map {
    final Map<String, dynamic> mappedData = {
      "title": title,
      "pros": pros,
      "cons": cons,
      "courseSubjectRating": courseSubjectsRating,
      "explanationsRating": explanationsRating,
      "punctualityRating": punctualityRating,
      "rating": rating
    };

    return mappedData;
  }
}
