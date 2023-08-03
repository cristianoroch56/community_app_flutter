class Profilemodel {
  String? message;
  ProfileData? data;

  Profilemodel({this.message, this.data});

  Profilemodel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  int? user;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? profilePic;
  String? relationWithMainMember;
  String? birthdate;
  String? education;
  bool? maritalStatus;
  String? currentlyLivingAt;
  String? createdAt;
  String? updatedAt;
  bool? pushNotification;

  ProfileData(
      {this.id,
      this.user,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.profilePic,
      this.relationWithMainMember,
      this.birthdate,
      this.education,
      this.maritalStatus,
      this.currentlyLivingAt,
      this.createdAt,
      this.updatedAt,
      this.pushNotification});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    profilePic = json['profile_pic'];
    relationWithMainMember = json['relation_with_main_member'];
    birthdate = json['birthdate'];
    education = json['education'];
    maritalStatus = json['marital_status'];
    currentlyLivingAt = json['currently_living_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushNotification = json['push_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_number'] = mobileNumber;
    data['profile_pic'] = profilePic;
    data['relation_with_main_member'] = relationWithMainMember;
    data['birthdate'] = birthdate;
    data['education'] = education;
    data['marital_status'] = maritalStatus;
    data['currently_living_at'] = currentlyLivingAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['push_notification'] = pushNotification;
    return data;
  }
}
