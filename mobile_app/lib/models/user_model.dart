class UserModel {
  String? uid;
  String? firstName;
  String? secondName;
  String? email;

  UserModel({this.uid, this.firstName, this.secondName, this.email});

  UserModel.fromMap(Map<String, dynamic> map)
      : email = map['email'] ?? "",
        uid = map['uid'] ?? "",
        firstName = map['firstName'] ?? "",
        secondName = map['secondName'] ?? "";
  
  Map<String, dynamic> toMap() {
        return {
          'email': email,
          'uid': uid,
          'firstName': firstName,
          'secondName': secondName,
        };
      }
}
