class User {
  
  final String _userID;
  final String _username;
  final double _avgRating;

  User(this._userID, this._username, this._avgRating);

  String get userID {
    return this._userID;
  }

  String get username {
    return this._username;
  }

  double get avgRating {
    return this._avgRating;
  }

}