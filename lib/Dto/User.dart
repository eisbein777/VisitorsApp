class User {
  String firstname;
  String lastname;
  String email;

  User(String firstname, String lastname, String email) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
  }

  User.fromJson(Map json)
      : firstname = json['FirstName'],
        lastname = json['LastName'],
        email = json['Email'];

  Map toJson() {
    return {'FirstName': firstname, 'LastName': lastname, 'Email': email};
  }
}
