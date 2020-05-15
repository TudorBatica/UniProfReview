class Review {
  final String author;
  final String authorReference;
  final String cons;
  final double courseSubjectsRating;
  final double explanationsRating;
  final String facultyName;
  final String facultyReference;
  final String professorFirstName;
  final String professorLastName;
  final String professorReference;
  final String pros;
  final double punctualityRating;
  final double rating;
  final String title;
  final String universityName;
  final String universityReference;

  Review(
      {this.author,
      this.authorReference,
      this.cons,
      this.courseSubjectsRating,
      this.explanationsRating,
      this.facultyName,
      this.facultyReference,
      this.professorFirstName,
      this.professorLastName,
      this.professorReference,
      this.pros,
      this.punctualityRating,
      this.rating,
      this.title,
      this.universityName,
      this.universityReference});

  factory Review.fromMap(Map<String, dynamic> map) => Review(
      author: map['author'],
      authorReference: map['author_reference'],
      cons: map['cons'],
      courseSubjectsRating: map['course_subjects_rating'].toDouble(),
      explanationsRating: map['explanations_rating'].toDouble(),
      facultyName: map['faculty_name'],
      facultyReference: map['faculty_reference'],
      professorFirstName: map['professor_first_name'],
      professorLastName: map['professor_last_name'],
      professorReference: map['professor_reference'],
      pros: map['pros'],
      punctualityRating: map['punctuality_rating'].toDouble(),
      rating: map['rating'].toDouble(),
      title: map['title'],
      universityName: map['university_name'],
      universityReference: map['university_reference']);
}