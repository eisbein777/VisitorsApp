class SignOut {
  String firstname;
  String lastname;

  SignOut(String firstname, String lastname, String email) {
    this.firstname = firstname;
    this.lastname = lastname;
  }

  SignOut.fromJson(Map json)
      : firstname = json['FirstName'],
        lastname = json['LastName'];

  Map toJson() {
    return {'FirstName': firstname, 'LastName': lastname};
  }
}
