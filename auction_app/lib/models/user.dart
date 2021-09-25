class User{
  final String firstName;
  final String lastName;
  final String img;
  final String email;
  final int phoneNo;
  final bool status;
  final UserLocation location;
  User(this.firstName, this.lastName, this.img, this.email, this.phoneNo, this.status, this.location );
  User.fromJson(Map<String, dynamic> json): firstName = json['first_name'], lastName = json['last_name'],
        email = json['email'], img = json['img'],
        phoneNo = json['phone_no'], status = json['status'],
      location = UserLocation.fromJson(json['address']);
  Map<String, dynamic> toJson()=>{
    'first_name': firstName,
    'last_name': lastName,
    'img': img,
    'email': email,
    'phone_no': phoneNo
  };
}
class UserLocation{
  final String district;
  final String province;
  UserLocation(this.province, this.district);
  UserLocation.fromJson(Map<String, dynamic> json): district = json['district'], province = json['province']; 
}
