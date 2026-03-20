import 'dart:io';

class UserModel {
  String? name;
  String? location;
  String? phone;
  File? profileImage;

  UserModel({this.name, this.location, this.phone, this.profileImage});

  //setter
  setName(String name) {
    this.name = name;
  }

  setProfileImage(File? proImage) {
    this.profileImage = proImage;
  }

  setLocation(String location) {
    this.location = location;
  }

  setPhone(String phone) {
    this.phone = phone;
  }

  //getter
  String? getName() {
    return name;
  }

  File? getProfileImage() {
    return profileImage;
  }

  String? getLocation() {
    return location;
  }

  String? getPhone() {
    return phone;
  }
}
