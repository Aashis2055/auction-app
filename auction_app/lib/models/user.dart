class User{
  final String firstName;
  final String lastName;
  final String img;
  final String email;
  final int phoneNo;
  final bool status;
  User(this.firstName, this.lastName, this.img, this.email, this.phoneNo, this.status );
  User.fromJson(Map<String, dynamic> json): firstName = json['firstname'], lastName = json['lastname'],
        email = json['email'], img = json['img'],
        phoneNo = json['phone_no'], status = json['status'];
  Map<String, dynamic> toJson()=>{
    'first_name': firstName,
    'last_name': lastName,
    'img': img,
    'email': email,
    'phone_no': phoneNo
  };
}
