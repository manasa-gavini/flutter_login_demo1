import 'package:firebase_database/firebase_database.dart';

class Userdata {
  String key;
  String firstname;
  String lastname;
  String email;
  String userId;

  Userdata(this.firstname, this.lastname, this.userId, this.email);

  Userdata.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    firstname = snapshot.value["firstname"],
    email = snapshot.value["email"],
    lastname = snapshot.value["lastname"];

  toJson() {
    return {
      "userId": userId,
      "firstname": firstname ,
      "lastname": lastname,
      "email": email,
    };
  }
}