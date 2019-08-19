import 'dart:typed_data';

class Visitor {
  String firstname;
  String lastname;
  String company;
  String personvisit;
  String tagid;
  Uint8List signature;

  Visitor(String firstname, String lastname, String company, String personvisit, String tagid, Uint8List signature) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.company = company;
    this.personvisit = personvisit;
    this.tagid = tagid;
    this.signature = signature;
  }

  Visitor.fromJson(Map json)
      : firstname = json['FirstName'],
        lastname = json['LastName'],
        company = json['Company'],
        personvisit = json['PersonVisting'],
        tagid = json['TagID'];

  Map toJson() {
    return {
      'FirstName': firstname,
      'LastName': lastname,
      'Company': company,
      'PersonVisting': personvisit,
      'TagID': tagid,
      'Signature' : signature
    };
  }
}
